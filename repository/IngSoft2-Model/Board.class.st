Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'totalBoardCells',
		'blackHoleIndex',
		'blackHoleOutIndex',
		'blackHolesFirstEntrance',
		'blackHolesSecondEntrance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> isAPositiveInteger: aNumber [

	(aNumber isInteger and: [ aNumber > 0 ]) ifFalse: [
		Error signal: 'Number of cells must be a positive integer.' ].
]

{ #category : 'as yet unclassified' }
Board class >> theCell: position isOutOfRange: range [

	( position > range ) ifTrue: [
		Error signal: 'The cells of the Black-Hole must in the board.' ].
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: aNumberOfCells [

	(self isAPositiveInteger: aNumberOfCells).
	^ self new initializeWith: aNumberOfCells
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: numberOfCells andABlackHoleBetweenCells: firstEntrance and: secondEntrance [
 
	self isAPositiveInteger: numberOfCells.
	self isAPositiveInteger: firstEntrance.
	self isAPositiveInteger: secondEntrance.
	
	self theCell: firstEntrance isOutOfRange: numberOfCells.
	self theCell: secondEntrance isOutOfRange: numberOfCells.	
	
	
	^ self new  initializeWith: numberOfCells
		andABlackHoleBeweenCells: firstEntrance 
		and: secondEntrance.
]

{ #category : 'as yet unclassified' }
Board >> blackHolesFirstEntrance [

	^ blackHolesFirstEntrance.
]

{ #category : 'as yet unclassified' }
Board >> blackHolesSecondEntrance [

	^ blackHolesSecondEntrance.
]

{ #category : 'initialization' }
Board >> initializeWith: aNumberOfCells [

	totalBoardCells := aNumberOfCells.
	


]

{ #category : 'accessing' }
Board >> initializeWith: numberOfCells andABlackHoleBeweenCells: firstEntrance and: secondEntrance [

	totalBoardCells := numberOfCells.
	blackHolesFirstEntrance := firstEntrance.
	blackHolesSecondEntrance := secondEntrance.
]

{ #category : 'initialization' }
Board >> numberOfCells [

	^ totalBoardCells 
]
