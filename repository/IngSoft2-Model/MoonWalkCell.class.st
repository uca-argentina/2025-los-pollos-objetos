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

	| instance |
	
   self isAPositiveInteger: aNumberOfCell.
   self isAPositiveInteger: aRequiredValue.
	instance := super initializeCellOn: aNumberOfCell.

   ^ instance withRequiredValue: aRequiredValue.
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
MoonWalkCell >> stepsBack [
 
    ^ numberOfCellsToGoBack negated.
]

{ #category : 'initialization' }
MoonWalkCell >> withRequiredValue: aRequiredValue [

    numberOfCellsToGoBack := aRequiredValue.
]
