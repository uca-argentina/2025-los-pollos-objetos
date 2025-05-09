Class {
	#name : 'BoardDecorator',
	#superclass : 'Board',
	#instVars : [
		'baseBoard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BoardDecorator class >> of: aBoard [
	^ self new initializeOf: aBoard.

]

{ #category : 'initialization' }
BoardDecorator >> initializeOf: aBoard [
	baseBoard := aBoard.
]

{ #category : 'initialization' }
BoardDecorator >> numberOfCells [
	^ baseBoard numberOfCells.
]
