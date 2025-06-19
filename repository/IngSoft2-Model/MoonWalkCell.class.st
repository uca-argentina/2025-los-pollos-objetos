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

    | shipsToAffect stepsBack |
    
    shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = currentShip ].
    stepsBack := numberOfCellsToGoBack negated.

    shipsToAffect do: [ :ship |
        (ship currentFuel >= numberOfCellsToGoBack)
            ifTrue: [ aGame move: ship by: stepsBack ]
            ifFalse: [
                aGame penalize: ship withTurns: 2.
            ].
    ].

]

{ #category : 'initialization' }
MoonWalkCell >> setUpOn: aNumberOfCell withRequiredValue: aRequiredValue [

    ships := OrderedCollection new.
    numberOfCell := aNumberOfCell.
    numberOfCellsToGoBack := aRequiredValue.
]
