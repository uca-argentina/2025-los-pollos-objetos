Class {
	#name : 'HyperGravityCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenAnHyperGravityCellIsInitializedWithANegativeNumberThenCreationFails [

	 self
        should: [HyperGravityCell initializeCellOn: -2 withRequiredValue: 3.]
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenHyperGravityCellIsCreatedWithNegativeRequiredValueThenItFails [

	 self
        should: [HyperGravityCell initializeCellOn: 4 withRequiredValue: -1]
        raise: Error
        withMessageText: 'Required value must be a positive integer.'.
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenShipArrivesToHyperGravityCellWithEnoughRollThenItContinuesFromThatCell [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add:
		(HyperGravityCell initializeCellOn: 5 withRequiredValue: 2).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	numberOfCells := 7.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	
	oneDice := ChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenShipArrivesToHyperGravityCellWithExactRollThenItContinuesFromThatCell [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add:
		(HyperGravityCell initializeCellOn: 5 withRequiredValue: 4).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	numberOfCells := 7.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	
	oneDice := ChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenShipArrivesToHyperGravityCellWithNotEnoughRollThenItDoesntMoveForward [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add:
		(HyperGravityCell initializeCellOn: 5 withRequiredValue: 6).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	numberOfCells := 7.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1
]
