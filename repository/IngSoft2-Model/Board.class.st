Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'totalBoardCells'
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

{ #category : 'initialization' }
Board >> initializeWith: aNumberOfCells [

	totalBoardCells := aNumberOfCells.
	


]

{ #category : 'initialization' }
Board >> numberOfCells [

	^ totalBoardCells 
]
