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
MoonWalkCell >> applyEffectTo: curentShip of: aGame [

	| shipsInGame |
	shipsInGame := aGame shipsPlaying.

	shipsInGame do:[:shipInGame |( ships includes: shipInGame ) ifFalse: [
			
			numberOfCellsToGoBack >= shipInGame currentFuel ifFalse: [ 
				shipInGame moveTo: shipInGame position - numberOfCellsToGoBack andConsume: numberOfCellsToGoBack 
				]
			] 
		].

]

{ #category : 'initialization' }
MoonWalkCell >> setUpOn: aNumberOfCell withRequiredValue: aRequiredValue [

    ships := OrderedCollection new.
    numberOfCell := aNumberOfCell.
    numberOfCellsToGoBack := aRequiredValue.
    ^ self
]
