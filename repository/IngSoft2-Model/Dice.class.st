Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> isAPositiveInteger: numberOfFaces [

	(numberOfFaces isInteger and: [ numberOfFaces > 0 ]) ifFalse: [
		Error signal: 'Number of faces must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Dice class >> withATotalNumberOfFacesOf: numberOfFaces [

	self isAPositiveInteger: numberOfFaces.

	^ self new initializeWith: numberOfFaces
]

{ #category : 'as yet unclassified' }
Dice >> beThrown [
	
	^ (1 to: self sizeOfTheDice) atRandom.
	
]

{ #category : 'initialization' }
Dice >> initializeWith: numberOfFaces [ 

	numberOfFacesOfTheDice := numberOfFaces
]

{ #category : 'as yet unclassified' }
Dice >> sizeOfTheDice [

	^ numberOfFacesOfTheDice .
]
