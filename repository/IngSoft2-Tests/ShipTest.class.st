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
ShipTest >> testWhenShipHasTenUnitsOfFuelAndConsumesOneThenItHasNineUnitsOfFuel [

	| aShip |
	aShip := Ship named: 'Serenity'.
	aShip chargeFuelUpTo: 10.
	aShip consumeFuel: 1.
	
	self assert: (aShip currentCharge) equals: 9.
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsChargedWithOneFuelUnitsThenItHasOneFuelUnit [

	| aShip |
	aShip := Ship named: 'Discovery One'.
	aShip chargeFuelUpTo: 1.
	
	self assert: (aShip currentCharge) equals: 1.
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
	aShip chargeFuelUpTo: 1.
	
	aShip moveTo: 1.
	
	self assert: (aShip position) equals: 1.
]
