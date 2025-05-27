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

    self isAPositiveInteger: aNumberOfCell.
    self requiredValueIsAPositiveInteger: aRequiredValue.

    ^ (self new) setUpOn: aNumberOfCell withRequiredValue: aRequiredValue
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
	diceThrow >= requiredValue ifFalse: [ "aShip setPositionBeforePlay: aGame positionBeforePlay
                andFuel: aGame fuelBeforePlay"
		aGame shipToLastPlay: aShip ]
]

{ #category : 'initialization' }
HyperGravityCell >> setUpOn: aNumberOfCell withRequiredValue: aRequiredValue [

    ships := OrderedCollection new.
    numberOfCell := aNumberOfCell.
    requiredValue := aRequiredValue.
    ^ self
]
