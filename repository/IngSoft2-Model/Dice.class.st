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
Dice class >> withATotalNumberOfFacesOf: numberOfFaces [
	^ self new initializeWith: numberOfFaces.
]

{ #category : 'initialization' }
Dice >> initializeWith: numberOfFaces [ 
	numberOfFacesOfTheDice := numberOfFaces
]

{ #category : 'as yet unclassified' }
Dice >> sizeOfTheDice [
	^ numberOfFacesOfTheDice .
]
