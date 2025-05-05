Class {
	#name : 'TwoFacesDiceTrickedToAlwaysReturnTwoWhenThrown',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
TwoFacesDiceTrickedToAlwaysReturnTwoWhenThrown class >> withTwoFaces [

	^ self new initializeWith: 2.
]

{ #category : 'initialization' }
TwoFacesDiceTrickedToAlwaysReturnTwoWhenThrown >> beThrown [
	
	^ 2.
]

{ #category : 'initialization' }
TwoFacesDiceTrickedToAlwaysReturnTwoWhenThrown >> initializeWith: numberOfFaces [ 

	numberOfFacesOfTheDice := numberOfFaces.
]

{ #category : 'initialization' }
TwoFacesDiceTrickedToAlwaysReturnTwoWhenThrown >> sizeOfTheDice [

	^ numberOfFacesOfTheDice .
]
