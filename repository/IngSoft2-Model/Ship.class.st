Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'shipsCurrentCell'
	],
	#classInstVars : [
		'shipsName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> named: aName [

	self shipHasAValid: aName.

	^ (self new initializeWith: aName) atStartingPosition.
]

{ #category : 'instance creation' }
Ship class >> shipHasAValid: aName [

	(aName isEmpty or: [ aName isNil ]) ifTrue: [
		Error signal: 'Ship must be initialized with a name.' ]
]

{ #category : 'accessing' }
Ship >> atStartingPosition [
	
	shipsCurrentCell := 0.
]

{ #category : 'as yet unclassified' }
Ship >> fly: aNumberOfCells [ 
	shipsCurrentCell := shipsCurrentCell + aNumberOfCells.
]

{ #category : 'accessing' }
Ship >> initializeWith: aName [

	shipsName := aName.
]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName.
]

{ #category : 'accessing' }
Ship >> position [
	
	^ shipsCurrentCell.
]

{ #category : 'as yet unclassified' }
Ship >> throw: dices [

  ^ (dices collect: [ :eachDice |
      (1 to: eachDice sizeOfTheDice) atRandom
  ]) sum.

]
