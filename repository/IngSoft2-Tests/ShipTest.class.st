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
ShipTest >> testWhenShipConsumesANegativeAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Elysium'.
	aShip chargeFuelUpTo: 10.
	
	self
		should: [aShip consumeFuel: -1]
		raise: Error
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipConsumesANonValidAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Elysium'.
	aShip chargeFuelUpTo: 10.
	
	self
		should: [aShip consumeFuel: 'dos']
		raise: Error
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasOneUnitOfFuelAndConsumesTwoUnitsThenCurrentChargeRemainsTheSame [

	| aShip |
	aShip := Ship named: 'Axiom'.
	aShip chargeFuelUpTo: 1.
	
	self
		should: [aShip consumeFuel: 2]
		raise: Error
		withMessageText: 'Ship has no enough fuel for this consumption'.
		
	self assert: (aShip currentCharge) equals: 1.
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasOneUnitOfFuelAndConsumesTwoUnitsThenItFails [

	| aShip |
	aShip := Ship named: 'Axiom'.
	aShip chargeFuelUpTo: 1.
	
	self
		should: [aShip consumeFuel: 2]
		raise: Error
		withMessageText: 'Ship has no enough fuel for this consumption'
	
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
ShipTest >> testWhenShipIsChargedWithANegativeAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Apolo'.
	
	self
		should: [aShip chargeFuelUpTo: -1]
		raise: Error
		"withMessageText: 'Ship must be charged with a positive amount of fuel.'"
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'.
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsChargedWithANonValidAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Elysium'.
	
	self
		should: [aShip chargeFuelUpTo: 'dos']
		raise: Error
		"withMessageText: 'Ship must be charged with a positive amount of fuel.'"
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'.
	
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
