Class {
	#name : 'CellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CellTest >> testWhenAShipEntersACellThenIsEffectivelyInThere [

	| aShip aCell |
	aShip := Ship named: 'Millenium Falcon'.
	aCell := Cell initializeCell.
	
	aCell enters: aShip.
	
	self assert: (aCell includes: aShip). 
	
	
]

{ #category : 'tests' }
CellTest >> testWhenAShipExitsACellThenIsEffectivelyOutThere [

	| aShip aCell |
	aShip := Ship named: 'Millenium Falcon'.
	aCell := Cell initializeCell.
	
	aCell enters: aShip.
	aCell leaves: aShip.
	
	self deny: (aCell includes: aShip). 
	
	
]
