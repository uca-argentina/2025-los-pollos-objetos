Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> testBanana [ 

	| aDice |
	aDice:= Dice withATotalNumberOfFacesOf: 10.
	self assert: (aDice sizeOfTheDice) equals: 10.
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
