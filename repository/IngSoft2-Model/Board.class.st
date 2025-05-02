Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'totalBoardCells',
		'blackHoleIndex',
		'blackHoleOutIndex'
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
Board class >> theExit: exit isBiggerThan: entry [

	( entry > exit ) ifTrue: [
		Error signal: 'The exit of the Black-Hole must be bigger than the entry.' ].
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: aNumberOfCells [

	(self isAPositiveInteger: aNumberOfCells).
	^ self new initializeWith: aNumberOfCells
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: numberOfCells withABlackHoleIn: blackHoleIndex wichOutIs: blackHoleOutIndex [
 
		
	self isAPositiveInteger: numberOfCells.
	self isAPositiveInteger: blackHoleIndex .
	self isAPositiveInteger: blackHoleOutIndex .
	
	self theCell: blackHoleOutIndex isOutOfRange: numberOfCells.
	self theCell: blackHoleIndex isOutOfRange: numberOfCells.	
	
	self theExit: blackHoleOutIndex  isBiggerThan: blackHoleIndex.
	

	
	^ self new  initializeWith: numberOfCells
	blackHoleAt: blackHoleIndex 
	withExitAt: blackHoleOutIndex .
]

{ #category : 'as yet unclassified' }
Board >> blackHoleEntry [
	^ blackHoleIndex.
]

{ #category : 'as yet unclassified' }
Board >> blackHoleExit [
	^ blackHoleOutIndex .
]

{ #category : 'initialization' }
Board >> initializeWith: aNumberOfCells [

	totalBoardCells := aNumberOfCells.
	


]

{ #category : 'accessing' }
Board >> initializeWith: numberOfCells blackHoleAt: blackHoleEntry withExitAt: blackHoleOut [
	totalBoardCells := numberOfCells.
	blackHoleIndex :=blackHoleEntry.
	blackHoleOutIndex :=blackHoleOut.
]

{ #category : 'initialization' }
Board >> numberOfCells [

	^ totalBoardCells 
]
