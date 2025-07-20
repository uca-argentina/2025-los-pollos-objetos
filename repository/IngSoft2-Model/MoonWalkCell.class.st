Class {
	#name : 'MoonWalkCell',
	#superclass : 'Cell',
	#instVars : [
		'requiredValue',
		'numberOfCellsToGoBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalkCell class >> initializeCellOn: aNumberOfCell withRequiredValue: aRequiredValue [

    self isAPositiveInteger: aNumberOfCell.
    self isAPositiveInteger: aRequiredValue.

    ^ (self new) setUpOn: aNumberOfCell withRequiredValue: aRequiredValue
]

{ #category : 'initialization' }
MoonWalkCell class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
        Error signal: 'Required value must be a positive integer.' ].
]

{ #category : 'initialization' }
MoonWalkCell >> applyEffectTo: currentShip of: aGame [

    | shipsToAffect |
    
    shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = currentShip ].
	 shipsToAffect do: [ :ship | aGame move: ship by: (self stepsBack) ].
]

{ #category : 'initialization' }
MoonWalkCell >> applyReversedEffectTo: aShip from: aGame [
	
	aGame move: aShip by: (self stepsBack).

]

{ #category : 'initialization' }
MoonWalkCell >> decideEffectoBasedOnStateOf: aShip of: aGame [

	(aGame isReversed: aShip)
	ifTrue: [ self applyReversedEffectTo: aShip from: aGame ]
	ifFalse: [ self applyEffectTo: aShip of: aGame ] .
]

{ #category : 'initialization' }
MoonWalkCell >> setUpOn: aNumberOfCell withRequiredValue: aRequiredValue [

    ships := OrderedCollection new.
    numberOfCell := aNumberOfCell.
    numberOfCellsToGoBack := aRequiredValue.
]

{ #category : 'initialization' }
MoonWalkCell >> stepsBack [
 
    ^ numberOfCellsToGoBack negated.
]
