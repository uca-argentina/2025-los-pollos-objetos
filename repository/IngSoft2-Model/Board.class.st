Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'totalBoardCells',
		'blackHoleIndex',
		'blackHoleOutIndex',
		'blackHolesFirstEntrance',
		'blackHolesSecondEntrance',
		'squares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> isAPositiveInteger: arg1 [

	(arg1 isInteger and: [ arg1 > 0 ]) ifFalse: [
		Error signal: 'Number of cells must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Board class >> the: arg1 isDifferentFrom: arg2 [

	arg1 = arg2 ifTrue: [
		Error signal:
			'The entrances of the Black Hole must be in different cells.' ]
]

{ #category : 'as yet unclassified' }
Board class >> the: arg1 isSmallerThan: arg2 [

	arg2 > arg1 ifTrue: [
		Error signal:
			'The First Entrance of Black Hole must come before the Second Entrance.' ]
]

{ #category : 'as yet unclassified' }
Board class >> theCell: arg1 isOutOfRange: arg2 [

	arg1 > arg2 ifTrue: [
		Error signal: 'The cells of the Black Hole must in the board.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: arg1 andABlackHoleBetweenCells: arg2 and: arg3 [

	self
		isAPositiveInteger: arg1;
		isAPositiveInteger: arg2;
		isAPositiveInteger: arg3;
		theCell: arg2 isOutOfRange: arg1;
		theCell: arg3 isOutOfRange: arg1;
		the: arg2 isDifferentFrom: arg3;
		the: arg3 isSmallerThan: arg2.
	^ self new
		  initializeWith: arg1
		  andABlackHoleBeweenCells: arg2
		  and: arg3
]

{ #category : 'as yet unclassified' }
Board class >> withSquares: aCollectionOfSquares [ 
	self isAPositiveInteger: aCollectionOfSquares size.
	^self new initializeWithSquareCollection: aCollectionOfSquares .
]

{ #category : 'as yet unclassified' }
Board >> blackHolesFirstEntrance [

	^ blackHolesFirstEntrance
]

{ #category : 'as yet unclassified' }
Board >> blackHolesIndexes [

	| blackHolesIndexs |
	blackHolesIndexs := OrderedCollection new.

	squares withIndexDo: [ :each :i | (each isKindOf: BalckHole ) ifTrue:[blackHolesIndexs add:i]].
	
	^ blackHolesIndexs .
]

{ #category : 'as yet unclassified' }
Board >> blackHolesSecondEntrance [

	^ blackHolesSecondEntrance
]

{ #category : 'accessing' }
Board >> initializeWith: arg1 andABlackHoleBeweenCells: arg2 and: arg3 [

	totalBoardCells := arg1.
	blackHolesFirstEntrance := arg2.
	blackHolesSecondEntrance := arg3
]

{ #category : 'initialization' }
Board >> initializeWithSquareCollection: aCollection [ 
	squares := aCollection .
]

{ #category : 'initialization' }
Board >> numberOfCells [

	^ totalBoardCells
]

{ #category : 'as yet unclassified' }
Board >> numberOfSquares [
	^squares size.
]
