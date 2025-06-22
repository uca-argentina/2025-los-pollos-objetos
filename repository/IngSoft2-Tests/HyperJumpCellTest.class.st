Class {
	#name : 'HyperJumpCellTest',
	#superclass : 'CellTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpCellTest >> should: arg1 raise: arg2 withMessageText: arg3 [

	self
		should: arg1
		raise: arg2
		withExceptionDo: [ :arg4 |
		self assert: arg4 messageText equals: arg3 ]
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
		should: [
			HyperJumpCell
				initializeCellOn: 4
				withParsecValues: #(  )
				boardLength: 100
				numberOfCells: 10 ]
		raise: Error
		withMessageText: 'Parsec values must be a non-empty array.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithInvalidParsecValuesThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn: 4
				withParsecValues: #( 'uno' 10 )
				boardLength: 100
				numberOfCells: 10 ]
		raise: Error
		withMessageText: 'All parsec values must be integers.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeBoardLengthThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn: 9
				withParsecValues: #( 10 10 )
				boardLength:  -1
				numberOfCells: 10 ]
		raise: Error
		withMessageText:
		'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeNumberOfCellThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn:  -1
				withParsecValues: #( 10 10 )
				boardLength: 100
				numberOfCells: 10 ]
		raise: Error
		withMessageText:
		'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeTotalNumberOfCellsThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn: 9
				withParsecValues: #( 10 10 )
				boardLength: 10
				numberOfCells:  -10 ]
		raise: Error
		withMessageText:
		'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'
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
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingLightYears [

	| aGame aBoard aShip ships oneDice dices boardLength distanceValues expectedPosition numberOfCells cells |
	boardLength := ParsecDistance with: 90.
	distanceValues := OrderedCollection with: (LightYearDistance with: 81).

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (HyperJumpCell
				initializeCellOn: 4
				withDistanceValues: distanceValues
				boardLength: boardLength
				numberOfCells: 9).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	numberOfCells := 9.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 9.
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

	expectedPosition := 4 + ((81 // 3) // (boardLength valueInParsecs // numberOfCells)). "81 años luz = 27 pársecs, 27 // 10 = 3 celdas"

	self assert: (aGame positionOf: aShip) equals: expectedPosition

]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard aShip ships oneDice dices expectedPosition numberOfCells cells distanceValues boardLength |
	
	boardLength := LightYearDistance with: 270.
	"parsecValues := #( 25 15 10 )."
	distanceValues := OrderedCollection with: (ParsecDistance with: 25).
	

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (HyperJumpCell
			 initializeCellOn: 4
			 withDistanceValues: distanceValues
			 boardLength: boardLength
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
		          andAWormHoleBetweenCells: 8
		          and: 9.
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

	expectedPosition := 4 + (25 // (boardLength valueInParsecs // numberOfCells) ).

	self assert: (aGame positionOf: aShip) equals: expectedPosition
]
