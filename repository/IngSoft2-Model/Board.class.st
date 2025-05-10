Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numberOfCells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withCells: aNumberOfCells [
	^ self new initializeWithCells: aNumberOfCells.
]

{ #category : 'initialization' }
Board >> initializeWithCells: aNumberOfCells [

	numberOfCells := aNumberOfCells.

]

{ #category : 'initialization' }
Board >> numberOfCells [

	^ numberOfCells.

]
