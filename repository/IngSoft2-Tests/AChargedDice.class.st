Class {
	#name : 'AChargedDice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
AChargedDice class >> isAPositiveInteger: numberOfFaces [

	(numberOfFaces isInteger and: [ numberOfFaces > 0 ]) ifFalse: [
		Error signal: 'Number of faces must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
AChargedDice class >> withATotalNumberOfFacesOf: numberOfFaces [

	self isAPositiveInteger: numberOfFaces.

	^ self new initializeWith: numberOfFaces andAFuelCharge: nil
]

{ #category : 'initialization' }
AChargedDice >> beThrown [
	
	^ numberOfFacesOfTheDice .
]

{ #category : 'initialization' }
AChargedDice >> initializeWith: numberOfFaces andAFuelCharge: anObject1 [ 

	numberOfFacesOfTheDice := numberOfFaces.
]

{ #category : 'as yet unclassified' }
AChargedDice >> sizeOfTheDice [

	^ numberOfFacesOfTheDice .
]
