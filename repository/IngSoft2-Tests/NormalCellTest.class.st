Class {
	#name : 'NormalCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
NormalCellTest >> testWhenANormalCellIsInitializedThenItHasANumber [

	| aNormalCell |
	aNormalCell := NormalCell initializeCellOn: 1.
	
	self assert: (aNormalCell number) equals: 1. 
]

{ #category : 'tests' }
NormalCellTest >> testWhenAShipEntersACellThenIsEffectivelyInThere [

	| aShip aNormalCell |
	aShip := Ship named: 'Millenium Falcon'.
	aNormalCell := NormalCell initializeCellOn: 1.
	
	aNormalCell enters: aShip.
	
	self assert: (aNormalCell includes: aShip).  
]
