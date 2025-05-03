Class {
	#name : 'OneCellBoard',
	#superclass : 'Object',
	#instVars : [
		'totalBoardCells'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
OneCellBoard class >> withOneCell [

	^ self new initializeWith: 1.
]

{ #category : 'initialization' }
OneCellBoard >> initializeWith: aNumberOfCells [

	totalBoardCells := aNumberOfCells.
]

{ #category : 'initialization' }
OneCellBoard >> numberOfCells [

	^ totalBoardCells 
]
