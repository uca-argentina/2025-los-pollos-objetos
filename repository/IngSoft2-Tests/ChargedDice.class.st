Class {
	#name : 'ChargedDice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
ChargedDice class >> isAPositiveInteger: numberOfFaces [

	(numberOfFaces isInteger and: [ numberOfFaces > 0 ]) ifFalse: [
		Error signal: 'Number of faces must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
ChargedDice class >> withATotalNumberOfFacesOf: numberOfFaces [
	self isAPositiveInteger: numberOfFaces.

	^ self new initializeWith: numberOfFaces.
]

{ #category : 'initialization' }
ChargedDice >> beThrown [
	
	^ numberOfFacesOfTheDice .
]

{ #category : 'initialization' }
ChargedDice >> initializeWith: numberOfFaces [ 

	numberOfFacesOfTheDice := numberOfFaces.
]
