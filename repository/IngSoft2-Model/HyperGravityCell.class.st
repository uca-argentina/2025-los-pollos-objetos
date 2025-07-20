Class {
	#name : 'HyperGravityCell',
	#superclass : 'Cell',
	#instVars : [
		'requiredValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperGravityCell class >> initializeCellOn: aNumberOfCell withRequiredValue: aRequiredValue [

   | instance |
	
	self isAPositiveInteger: aNumberOfCell.
   self requiredValueIsAPositiveInteger: aRequiredValue.
	instance := super initializeCellOn: aNumberOfCell.

   ^ instance withRequiredValue: aRequiredValue
]

{ #category : 'initialization' }
HyperGravityCell class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
        Error signal: 'Number of cell must be a positive integer.' ].
]

{ #category : 'initialization' }
HyperGravityCell class >> requiredValueIsAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
        Error signal: 'Required value must be a positive integer.' ].
]

{ #category : 'initialization' }
HyperGravityCell >> applyEffectTo: aShip of: aGame [

	| diceThrow |
	diceThrow := aGame lastDiceThrow.
	diceThrow >= requiredValue ifTrue: [ ^ self ].
	
	aGame returnToInitialPosition: aShip.
	aGame discardOneTurbineOf: aShip.
]

{ #category : 'initialization' }
HyperGravityCell >> applyReversedEffectTo: aShip from: aGame [
	
	| shipsToAffect diceThrow |
	
	diceThrow := aGame lastDiceThrow.
	diceThrow >= requiredValue ifTrue: [ ^ self ].
	shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = aShip].
	shipsToAffect do: [ :ship | aGame returnToInitialPosition: ship.
										aGame discardOneTurbineOf: ship. ].
]

{ #category : 'initialization' }
HyperGravityCell >> withRequiredValue: aRequiredValue [

    requiredValue := aRequiredValue.
]
