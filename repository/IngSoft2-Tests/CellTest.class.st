Class {
	#name : 'CellTest',
	#superclass : 'BoardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
CellTest >> testWhenACellIsInitializedThenItHasANumber [

	| aCell |
	aCell := Cell initializeCellOn: 1.
	
	self assert: (aCell number) equals: 1. 
]

{ #category : 'tests' }
CellTest >> testWhenACellIsInitializedWithANegativeNumberThenCreationFails [

	 self
        should: [Cell initializeCellOn: -1]
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
CellTest >> testWhenACellIsInitializedWithANonValidNumberThenCreationFails [

	 self
        should: [Cell initializeCellOn: 'dos']
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
CellTest >> testWhenAShipEntersACellThenIsEffectivelyInThere [

	| aShip aCell aDice dices |
	aDice := AChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: aDice.
	aShip := Ship named: 'Millenium Falcon' withAChargeBasedOn: dices.
	aCell := Cell initializeCellOn: 1.

	aCell enters: aShip.

	self assert: (aCell includes: aShip)
]

{ #category : 'tests' }
CellTest >> testWhenAShipExitsACellThenIsEffectivelyOutThere [

	| aShip aCell aDice dices |
	aDice := AChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: aDice.
	aShip := Ship named: 'Millenium Falcon' withAChargeBasedOn: dices.
	aCell := Cell initializeCellOn: 1.

	aCell enters: aShip.
	aCell leaves: aShip.

	self deny: (aCell includes: aShip)
]
