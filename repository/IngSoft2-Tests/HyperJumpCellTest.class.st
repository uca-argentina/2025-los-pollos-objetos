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

	| aGame aBoard ships oneDice dices boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs firstShip secondShip thirdShip fourthShip numberOfCells someProbabilities aCellGenerator |
	
	boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 ).
	
    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperJumpCell
		                 initializeCellOn: 4
		                 withParsecValues: parsecValues
		                 boardLength: boardLengthInParsecs
		                 numberOfCells: 10) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 3.


	firstShip := Ship named: 'Venture1'.
	secondShip := Ship named: 'Millenium Falcon1'.
	thirdShip := Ship named: 'Venture2'.
	fourthShip := Ship named: 'Millenium Falcon2'.
	ships := OrderedCollection
		         with: firstShip
		         with: secondShip
		         with: thirdShip
		         with: fourthShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.

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

	self assert: fourthShip position equals: expectedPosition
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

| aGame aBoard aShip ships oneDice dices boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs anotherShip aHyperJumpCell numberOfCells someProbabilities aCellGenerator |
    
    boardLengthInParsecs := 100.
    cellLengthInParsecs := 10.
    parsecValues := #(25 15 10). 

    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperJumpCell
		                 initializeCellOn: 4
		                 withParsecValues: parsecValues
		                 boardLength: boardLengthInParsecs
		                 numberOfCells: 10) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 3.


    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Millenium Falcon'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 3.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame executeTurn.
	 aGame executeTurn.

    expectedPosition := 4 + (15 // cellLengthInParsecs).
    
    self assert: anotherShip position equals: expectedPosition.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellQAndRunsOutOfFuelToAdvanceThenItStaysOnTheCell [

| aGame aBoard aShip ships oneDice dices boardLengthInParsecs parsecValues cellLengthInParsecs aHyperJumpCell numberOfCells someProbabilities aCellGenerator |

    boardLengthInParsecs := 100.
    cellLengthInParsecs := 10.
    parsecValues := #(30 15 10). 

    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperJumpCell
		                 initializeCellOn: 4
		                 withParsecValues: parsecValues
		                 boardLength: boardLengthInParsecs
		                 numberOfCells: 10) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 3.


    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 3.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
    
    aGame executeTurn .

    "expectedPosition := 4 + (40 // cellLengthInParsecs)."

    self assert: aShip position equals: 4.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

| aGame aBoard aShip ships oneDice dices boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs aHyperJumpCell numberOfCells someProbabilities aCellGenerator |
    
    boardLengthInParsecs := 100.
    cellLengthInParsecs := 10.
    parsecValues := #(25 15 10). 

    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperJumpCell
		                 initializeCellOn: 4
		                 withParsecValues: parsecValues
		                 boardLength: boardLengthInParsecs
		                 numberOfCells: 10) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 3.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.
    oneDice := ChargedDice withATotalNumberOfFacesOf: 3.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
    
    aGame executeTurn .

    expectedPosition := 4 + (25 // cellLengthInParsecs).

    self assert: aShip position equals: expectedPosition.
]
