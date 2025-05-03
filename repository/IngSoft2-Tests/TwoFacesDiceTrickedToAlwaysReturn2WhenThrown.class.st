Class {
	#name : 'TwoFacesDiceTrickedToAlwaysReturn2WhenThrown',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
TwoFacesDiceTrickedToAlwaysReturn2WhenThrown class >> withTwoFaces [

	^ self new initializeWith: 2.
]

{ #category : 'initialization' }
TwoFacesDiceTrickedToAlwaysReturn2WhenThrown >> beThrown [
	
	^ 2.
]

{ #category : 'initialization' }
TwoFacesDiceTrickedToAlwaysReturn2WhenThrown >> initializeWith: numberOfFaces [ 

	numberOfFacesOfTheDice := numberOfFaces.
]

{ #category : 'initialization' }
TwoFacesDiceTrickedToAlwaysReturn2WhenThrown >> sizeOfTheDice [

	^ numberOfFacesOfTheDice .
]
