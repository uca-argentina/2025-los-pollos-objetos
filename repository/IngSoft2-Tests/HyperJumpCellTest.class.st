Class {
	#name : 'HyperJumpCellTest',
	#superclass : 'TestCase',
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
HyperJumpCellTest >> testWhenAFourthShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingLightYears [

	| aGame aBoard ships oneDice dices expectedPosition firstShip secondShip thirdShip fourthShip numberOfCells cells boardLength distanceValues |
	"boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 )."
	
	boardLength := ParsecDistance with: 100.
	distanceValues := OrderedCollection with: (LightYearDistance with: 75) with: (LightYearDistance with: 45) with: (LightYearDistance with: 30).
	
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

	self assert: (aGame positionOf: fourthShip) equals: 6.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAFourthShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard ships oneDice dices expectedPosition firstShip secondShip thirdShip fourthShip numberOfCells cells boardLength distanceValues |
	"boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 )."
	
	boardLength := ParsecDistance with: 100.
	distanceValues := OrderedCollection with: (ParsecDistance with: 25) with: (ParsecDistance with: 15) with: (ParsecDistance with: 10).
	
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

	self assert: (aGame positionOf: fourthShip) equals: 6.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithEmptyParsecValuesThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn: 4
				withDistanceValues: OrderedCollection new
				boardLength: 100
				numberOfCells: 10 ]
		raise: Error
		withMessageText: 'Distance values must be a non-empty array.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithInvalidParsecValuesThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn: 4
				withDistanceValues: (OrderedCollection with: (ParsecDistance with: 'one'))
				boardLength: 100
				numberOfCells: 10 ]
		raise: Error
		withMessageText: 'All values must be integers.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAHyperJumpCellIsInitializedWithNegativeBoardLengthThenCreationFails [

	self
		should: [
			HyperJumpCell
				initializeCellOn: 9
				withDistanceValues: (OrderedCollection with: (ParsecDistance with: 10))
				boardLength:  (ParsecDistance with: -1)
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
				withDistanceValues: (OrderedCollection with: (ParsecDistance with: 10))
				boardLength: (ParsecDistance with: 100)
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
				withDistanceValues: (OrderedCollection with: (ParsecDistance with: 10))
				boardLength: (ParsecDistance with: 10)
				numberOfCells:  -10 ]
		raise: Error
		withMessageText:
		'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.'
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenASecondShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard aShip ships oneDice dices expectedPosition anotherShip numberOfCells cells boardLength distanceValues |
	
	"boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 25 15 10 )."
	
	boardLength := ParsecDistance with: 100.
	distanceValues := OrderedCollection with: (ParsecDistance with: 25) with: (ParsecDistance with: 15).

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

	self assert: (aGame positionOf: anotherShip) equals: 5.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellAndRunsOutOfFuelToAdvanceThenItReturnsToTheInitialPosition [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells boardLength distanceValues |
	"boardLengthInParsecs := 100.
	cellLengthInParsecs := 10.
	parsecValues := #( 30 15 10 )."
	
	boardLength := ParsecDistance with: 100.
	distanceValues := OrderedCollection with: (ParsecDistance with: 30) with: (ParsecDistance with: 15) with: (ParsecDistance with: 10).

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

	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingLightYears [

	| aGame aBoard aShip ships oneDice dices boardLength distanceValues numberOfCells cells |
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

	self assert: (aGame positionOf: aShip) equals: 6.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenAShipArrivesToHyperJumpCellThenItAdvancesTheCorrespondingParsecs [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells distanceValues boardLength |
	
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

	self assert: (aGame positionOf: aShip) equals: 6.
]

{ #category : 'tests' }
HyperJumpCellTest >> testWhenBoardAndDistanceValuesAreBothInLightYearsThenAShipItAdvancesTheCorrespondingLightYears [

	| aGame aBoard aShip ships oneDice dices boardLength distanceValues numberOfCells cells |
	boardLength := LightYearDistance with: 270.
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

	self assert: (aGame positionOf: aShip) equals: 6.
]
