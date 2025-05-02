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
Board class >> isAPositiveInteger: aNumberOfCells [

	(aNumberOfCells isInteger and: [ aNumberOfCells > 0 ]) ifFalse: [
		Error signal: 'Number of cells must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: aNumberOfCells [

	self isAPositiveInteger: aNumberOfCells.

	^ self new initializeWith: aNumberOfCells
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: numberOfCells withABlackHoleIn: blackHoleIndex wichOutIs: blackHoleOutIndex [ 
	^ self new  initializeWith: numberOfCells
	blackHoleAt: blackHoleIndex 
	withExitAt: blackHoleOutIndex .
]

{ #category : 'as yet unclassified' }
Board >> blackHoleIsIn [
	^ blackHoleIndex.
]

{ #category : 'as yet unclassified' }
Board >> blackHoleOutIsIn [
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
