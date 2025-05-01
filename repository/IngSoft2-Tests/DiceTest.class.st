Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> should: anErrorBlock raise: anErroClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErroClass
		withExceptionDo: [ :error | self assert: (error messageText ) equals: errorMessage ]
	
]

{ #category : 'tests' }
DiceTest >> testWhenDiceIsCreatedWithInvalidNumberOfFacesThenCreationFails [

	self
		should: [Dice withATotalNumberOfFacesOf: -1]
		raise: Error
		withMessageText: 'Number of faces must be a positive integer.' .
]

{ #category : 'tests' }
DiceTest >> testWhenDiceIsCreatedWithNonIntergerAmountOfFacesThenCreationFails [

	self
		should: [Dice withATotalNumberOfFacesOf: 'two']
		raise: Error
		withMessageText: 'Number of faces must be a positive integer.' .
]

{ #category : 'tests' }
DiceTest >> testWhenDiceIsCreatedWithOneFaceThenHasOneFace [

	| aDice |
	"aDice:= Dice new."
	aDice:= Dice withATotalNumberOfFacesOf: 1.
	
	self assert: (aDice sizeOfTheDice) equals: 1.
]

{ #category : 'tests' }
DiceTest >> testWhenDiceIsCreatedWithTenFacesThenHasTenFaces [

	| aDice |
	aDice:= Dice withATotalNumberOfFacesOf: 10.
	self assert: (aDice sizeOfTheDice) equals: 10.
]

{ #category : 'tests' }
DiceTest >> testWhenDiceIsCreatedWithZeroFacesThenCreationFails [

	self
		should: [Dice withATotalNumberOfFacesOf: 0]
		raise: Error
		withMessageText: 'Number of faces must be a positive integer.' .
]
