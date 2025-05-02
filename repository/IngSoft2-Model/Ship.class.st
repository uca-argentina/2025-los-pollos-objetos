Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName'
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

	^ self new initializeWith: aName
]

{ #category : 'instance creation' }
Ship class >> shipHasAValid: aName [

	(aName isEmpty or: [ aName isNil ]) ifTrue: [
		Error signal: 'Ship must be initialized with a name.' ]
]

{ #category : 'accessing' }
Ship >> initializeWith: aName [

	shipsName := aName.
]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName.
]

{ #category : 'as yet unclassified' }
Ship >> throw: dices [

  ^ (dices collect: [ :eachDice |
      (1 to: eachDice sizeOfTheDice) atRandom
  ]) sum.

]
