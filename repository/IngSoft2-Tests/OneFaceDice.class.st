Class {
	#name : 'OneFaceDice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
OneFaceDice class >> withOneFace [


	^ self new initializeWith: 1.
]

{ #category : 'initialization' }
OneFaceDice >> initializeWith: numberOfFaces [ 
	numberOfFacesOfTheDice := numberOfFaces
]

{ #category : 'as yet unclassified' }
OneFaceDice >> sizeOfTheDice [
	^ numberOfFacesOfTheDice .
]
