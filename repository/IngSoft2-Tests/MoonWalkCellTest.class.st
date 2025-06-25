Class {
	#name : 'MoonWalkCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
MoonWalkCellTest >> should: arg1 raise: arg2 withMessageText: arg3 [

	self
		should: arg1
		raise: arg2
		withExceptionDo: [ :arg4 |
		self assert: arg4 messageText equals: arg3 ]
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenAShipArrivesToAMoonWalkCellAndTheEffectIsAppliedButTheOtherShipHasNoEnoughFuelToGoBackThenItReturnsToTheInitialPosition [

	| aGame aBoard aShip ships oneDice dices anotherShip numberOfCells cells |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (MoonWalkCell initializeCellOn: 7 withRequiredValue: 10).
	cells add: (NormalCell initializeCellOn: 8).
	numberOfCells := 8.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 2
		          and: 3.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	ships := OrderedCollection new.
	ships add: aShip.
	ships add: anotherShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.
	aGame executeTurn.
	aGame skipTurnFor: aShip.
	aGame skipTurnFor: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 1.
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenAShipArrivesToAMoonWalkCellThenThatShipRemainsThereAndTheOtherShipsGoBackANumberOfCells [

	| aGame aBoard aShip ships oneDice dices anotherShip numberOfCells cells |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (MoonWalkCell initializeCellOn: 5 withRequiredValue: 2).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	numberOfCells := 7.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	ships := OrderedCollection new.
	ships add: aShip.
	ships add: anotherShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.
	aGame executeTurn.
	aGame skipTurnFor: aShip.
	aGame skipTurnFor: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5.
	self assert: (aGame positionOf: anotherShip) equals: 1.
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenMoonWalkCellIsCreatedOnANegativeCellThenCreationFails [

	self
		should: [ MoonWalkCell initializeCellOn:  -4 withRequiredValue: 1 ]
		raise: Error
		withMessageText: 'Required value must be a positive integer.'
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenMoonWalkCellIsCreatedWithNegativeRequiredValueThenCreationFails [

	self
		should: [ MoonWalkCell initializeCellOn: 4 withRequiredValue:  -1 ]
		raise: Error
		withMessageText: 'Required value must be a positive integer.'
]
