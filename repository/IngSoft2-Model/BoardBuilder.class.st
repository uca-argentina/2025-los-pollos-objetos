Class {
	#name : 'BoardBuilder',
	#superclass : 'Object',
	#instVars : [
		'numberOfCells',
		'blackHolesFirstEntrance',
		'blackHolesSecondEntrance',
		'decorators'
	],
	#classInstVars : [
		'numberOfCells',
		'blackHoleFirstEntrance',
		'blackHoleSecondEntrance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
BoardBuilder >> build [
	| board |
	self validate.
	board := Board withCells: numberOfCells.
	
	^ board := BlackHoleBoard of: board from: blackHolesFirstEntrance to: blackHolesSecondEntrance.
]

{ #category : 'initialization' }
BoardBuilder >> initialize [
	decorators := OrderedCollection new.
	blackHolesFirstEntrance := nil.
	blackHolesSecondEntrance := nil.
]

{ #category : 'initialization' }
BoardBuilder >> isAPositiveInteger: aNumber [

	 (aNumber isInteger and: [ aNumber > 0 ] ) ifFalse: [
		Error signal: 'Number of cells must be a positive integer.' ]
]

{ #category : 'initialization' }
BoardBuilder >> isWithinBoardsRangeThe: secondEntrance [

	secondEntrance > numberOfCells ifTrue: [
		Error signal: 'The Black Hole entrance must be within the valid range of board cells (1 to ', 			numberOfCells asString, ').' ]
]

{ #category : 'initialization' }
BoardBuilder >> the: secondEntrance isBiggerThanThe: firstEntrance [

	firstEntrance > secondEntrance ifTrue: [
		Error signal: 'The First Entrance of Black Hole must come before the Second Entrance' ]
]

{ #category : 'initialization' }
BoardBuilder >> the: secondEntrance isDifferentFromThe: firstEntrance [

	firstEntrance = secondEntrance ifTrue: [
		Error signal: 'The entrances of the Black Hole must be in different cells' ]
	
]

{ #category : 'initialization' }
BoardBuilder >> validate [

	(self isAPositiveInteger: numberOfCells).
	(blackHolesFirstEntrance notNil and: [ blackHolesSecondEntrance notNil ]) ifTrue: [
		self validateBlackHoleFrom: blackHolesFirstEntrance to: blackHolesSecondEntrance ].
]

{ #category : 'initialization' }
BoardBuilder >> validateBlackHoleFrom: firstEntrance to: secondEntrance [

	self isAPositiveInteger: firstEntrance.
	self isAPositiveInteger: secondEntrance.
	self the: secondEntrance isDifferentFromThe: firstEntrance.
	self the: secondEntrance isBiggerThanThe: firstEntrance.
	self isWithinBoardsRangeThe: firstEntrance.
	self isWithinBoardsRangeThe: secondEntrance
]

{ #category : 'initialization' }
BoardBuilder >> withBlackHoleFrom: firstEntrance to: secondEntrance [

    self validateBlackHoleFrom: firstEntrance to: secondEntrance.
    blackHolesFirstEntrance := firstEntrance.
    blackHolesSecondEntrance := secondEntrance.
]

{ #category : 'initialization' }
BoardBuilder >> withCells: aNumberOfCells [

	self isAPositiveInteger: aNumberOfCells.
	numberOfCells := aNumberOfCells .
]
