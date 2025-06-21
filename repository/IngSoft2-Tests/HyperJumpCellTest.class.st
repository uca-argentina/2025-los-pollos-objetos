Class {
	#name : 'HyperJumpCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAFourthShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard ships oneDice dices boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs firstShip secondShip thirdShip fourthShip numberOfCells cells |
	boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 ).

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (HyperJumpCell
			 initializeCellOn: 4
			 withParsecValues: parsecValues
			 boardLength: boardLengthInParsecs
			 numberOfCells: 10).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	firstShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	secondShip := Ship named: 'Millenium Falcon1' withAChargeBasedOn: dices.
	thirdShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	fourthShip := Ship named: 'The Batwing' withAChargeBasedOn: dices.
	ships := OrderedCollection
		         with: firstShip
		         with: secondShip
		         with: thirdShip
		         with: fourthShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.
	aGame executeTurn.
	aGame executeTurn.
	aGame executeTurn.

	expectedPosition := 4 + (25 // cellLengthInParsecs).

	self assert: (aGame positionOf: fourthShip) equals: expectedPosition
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithEmptyParsecValuesThenCreationFails [

	 self
        should: [HyperJumpCell initializeCellOn: 4 withParsecValues: #() boardLength: 100 numberOfCells: 10.]
        raise: Error
        withMessageText: 'Parsec values must be a non-empty array.'.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithInvalidParsecValuesThenCreationFails [

	 self
        should: [HyperJumpCell initializeCellOn: 4 withParsecValues: #('uno' 10) boardLength: 100 numberOfCells: 10.]
        raise: Error
        withMessageText: 'All parsec values must be integers.'.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeBoardLengthThenCreationFails [

	 self
        should: [HyperJumpCell initializeCellOn: 9 withParsecValues: #(10 10) boardLength: -1 numberOfCells: 10.]
        raise: Error
        withMessageText: 'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeNumberOfCellThenCreationFails [

	 self
        should: [HyperJumpCell initializeCellOn: -1 withParsecValues: #(10 10) boardLength: 100 numberOfCells: 10.]
        raise: Error
        withMessageText: 'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeTotalNumberOfCellsThenCreationFails [

	 self
        should: [HyperJumpCell initializeCellOn: 9 withParsecValues: #(10 10) boardLength: 10 numberOfCells: -10.]
        raise: Error
        withMessageText: 'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenASecondShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard aShip ships oneDice dices boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs anotherShip numberOfCells cells |
	boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 ).

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (HyperJumpCell
			 initializeCellOn: 4
			 withParsecValues: parsecValues
			 boardLength: boardLengthInParsecs
			 numberOfCells: 10).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.
	aGame executeTurn.

	expectedPosition := 4 + (15 // cellLengthInParsecs).

	self assert: (aGame positionOf: anotherShip) equals: expectedPosition
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellQAndRunsOutOfFuelToAdvanceThenItReturnsToTheInitialPosition [

	| aGame aBoard aShip ships oneDice dices boardLengthInParsecs parsecValues cellLengthInParsecs numberOfCells cells |
	boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 30 15 10 ).

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (HyperJumpCell
			 initializeCellOn: 4
			 withParsecValues: parsecValues
			 boardLength: boardLengthInParsecs
			 numberOfCells: 10).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard aShip ships oneDice dices boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs numberOfCells cells |
	boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 ).

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (HyperJumpCell
			 initializeCellOn: 4
			 withParsecValues: parsecValues
			 boardLength: boardLengthInParsecs
			 numberOfCells: 10).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	expectedPosition := 4 + (25 // cellLengthInParsecs).

	self assert: (aGame positionOf: aShip) equals: expectedPosition
]
