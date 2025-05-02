Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
