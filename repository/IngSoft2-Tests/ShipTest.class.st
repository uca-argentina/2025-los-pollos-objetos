Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
ShipTest >> testWhenNewShipIsCreatedThenItHasAName [

	| aShip |
	
	"aShip := Ship new."
	aShip := Ship named: 'Millenium Falcon'.
	
	self assert: (aShip name) equals: 'Millenium Falcon'
]

{ #category : 'tests' }
ShipTest >> testWhenNewShipIsInstancedWithANameThenItHasAName [

	| aShip |
	
	aShip := Ship named: 'The Batwing'.
	
	self assert: (aShip name) equals: 'The Batwing'
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsCreatedThenItStarsAtStartingPosition [

	| aShip |
	
	aShip := Ship named: 'Discovery One'.
	
	self assert: (aShip position) equals: 0.
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsCreatedWithNoNameThenCreationFails [

	self
		should: [Ship named: '']
		raise: Error
		withMessageText: 'Ship must be initialized with a name.'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipMovesOnePositionFromStartingPositionThenItMovesAccordingly [

	| aShip |
	
	aShip := Ship named: 'Discovery One'.
	aShip fly: 1.
	
	self assert: (aShip position) equals: 1.
]

{ #category : 'tests' }
ShipTest >> testWhenShipThrowsADiceThenDiceIsThrownAndANumberIsReturned [

	| aShip aDice dices |
	
	aShip := Ship named: 'USS Enterprise'.
	aDice := Dice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: aDice.
	
	"self assert: (aShip throw: aDice) equals: 1."
	self assert: (aShip throw: dices) isInteger.
]

{ #category : 'tests' }
ShipTest >> testWhenShipThrowsDicesThenItMovesAsMuchPositionAsTheResultOfTheThrowIs [

	
	| aShip aDice dices throwResult |
	
	aShip := Ship named: 'Nebuchadnezzar'.
	aDice := Dice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: aDice.
	
	throwResult := aShip throw: dices.
	
	self assert: (aShip position) equals: (throwResult).
]

{ #category : 'tests' }
ShipTest >> testWhenShipThrowsMoreThanOneDiceThenTheDicesAreThrownAndANumberIsReturned [

	| aShip oneDice anotherDice dices |
	
	aShip := Ship named: 'Slave I'.
	oneDice := Dice withATotalNumberOfFacesOf: 6.
	anotherDice := Dice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice with: anotherDice.
	
	self assert: (aShip throw: dices) isInteger.
]
