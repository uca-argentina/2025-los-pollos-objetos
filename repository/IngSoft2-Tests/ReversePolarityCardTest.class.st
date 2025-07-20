Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversePolarityCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAfterAnotherReversePolarityCardAndThatShipFallsIntoAAtomicBombThenTheReversalIsReversed [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anotherReversePolarityCard cards aDeck aReversePolarityCard aOverloadCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (AtomicBombCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 9.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anotherReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCard := ReversePolarityCard new.
	aOverloadCard := OverloadCard new.
	cards := OrderedCollection with: aReversePolarityCard with: anotherReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 7 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	anotherReversePolarityCard selectedCell: 7 of: aGame.
	aGame playCard: anotherReversePolarityCard from: aShip to: anotherShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAAtomicBombThenNoShipsAreAffectedByTheAtomicBomb [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (AtomicBombCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip ) equals: 8.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoABlackHoleThenTheCurrentShipsIsntffectedByTheBlackHole [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (BlackHoleCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: anotherShip) equals: 8.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoABlackHoleThenTheCurrentShipsIsntffectedByTheBlackHoleAndDoesntLoseATurbine [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (BlackHoleCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: anotherShip) equals: 8.
	self assert: (aGame remainingTurbinesOf: anotherShip) equals: 3.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoABlackHoleThenTheOtherShipsAreAffectedByTheBlackHole [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (BlackHoleCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 10.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 3.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoABlackHoleThenTheOtherShipsAreAffectedByTheBlackHoleAndTheyAllLoseOneTurbine [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (BlackHoleCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 10.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 3.
	self assert: (aGame remainingTurbinesOf: aShip) equals: 2.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoACardSpawnerCellThenTheAffectedShipDoesNotPickACard [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard aOverloadCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (CardSpawnerCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 9.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	aOverloadCard := OverloadCard new.
	cards := OrderedCollection with: aReversePolarityCard with: anAccelerationCard with: aOverloadCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aReversePolarityCard selectedCell: 7 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame cardManagerOf: anotherShip ) cardsInHand size  equals: 1.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoACardSpawnerCellThenTheOtherShipsPickACard [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard aOverloadCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (CardSpawnerCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 9.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	aOverloadCard := OverloadCard new.
	cards := OrderedCollection with: aReversePolarityCard with: anAccelerationCard with: aOverloadCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aReversePolarityCard selectedCell: 7 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame cardManagerOf: aShip) cardsInHand size  equals: 4.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAHyperGravityThenTheCurrentShipsIsntffectedByTheCell [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (HyperGravityCell initializeCellOn: 8 withRequiredValue: 7).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: anotherShip) equals: 8.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAHyperGravityThenTheCurrentShipsIsntffectedByTheCellAndDoesntLoseATurbine [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (HyperGravityCell initializeCellOn: 8 withRequiredValue: 7).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: anotherShip) equals: 8.
	self assert: (aGame remainingTurbinesOf: anotherShip) equals: 3.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAHyperGravityThenTheOtherShipsAreffectedByTheCell [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (HyperGravityCell initializeCellOn: 8 withRequiredValue: 7).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAHyperGravityThenTheOtherShipsAreffectedByTheCellAndTheyAllLoseATurbine [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (HyperGravityCell initializeCellOn: 8 withRequiredValue: 7).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
	self assert: (aGame remainingTurbinesOf: aShip) equals: 2.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAHyperJumpThenTheCurrentShipIsntAffectedByTheCell [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells distanceValues boardLength anotherShip anAccelerationCard aReversePolarityCard cards aDeck |
	
	boardLength := LightYearDistance with: 270.
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
	anotherShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 4 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAHyperJumpThenTheOtherShipsAreAffectedByTheCell [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells distanceValues boardLength anotherShip anAccelerationCard aReversePolarityCard cards aDeck |
	
	boardLength := LightYearDistance with: 270.
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
	anotherShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 4 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 6.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAMoonWalkCellThenTheCurrentShipIsntAffectedByTheMoonWalk [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (MoonWalkCell initializeCellOn: 8 withRequiredValue: 2).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: anotherShip ) equals: 6.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAMoonWalkCellThenTheOtherShipsAreAffectedByTheMoonWalk [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (MoonWalkCell initializeCellOn: 8 withRequiredValue: 2).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 8 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip ) equals: 6.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoANonReversedAtomicBombThenTheReversedIsntApplied [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (AtomicBombCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (AtomicBombCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 12 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
	self assert: (aGame positionOf: anotherShip ) equals: 1.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoANonReversedBlackHoleThenTheReverseInstApplied [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (BlackHoleCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (BlackHoleCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aGame playCard: anAccelerationCard from: anotherShip to: aShip.
	aReversePolarityCard selectedCell: 12 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAWormHoleThenTheCurrentShipIsntAffectedByTheWormHole [

	| aGame aBoard aShip ships oneDice dices blackHolesFirstEntrance shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator anotherShip anAccelerationCard aReversePolarityCard cards aDeck |
	numberOfCells := 25.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 5
		          and: 20.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 19.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Elysium' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Axiom' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 20 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	aGame executeTurn.

	shipPositionAfterTheDices := aGame positionOf: aShip.
	blackHolesFirstEntrance := aBoard wormsHolesFirstEntrance.

	self
		deny: shipPositionAfterTheDices
		equals: blackHolesFirstEntrance.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAWormHoleThenTheOtherShipsAreAffectedByTheWormHole [

	| aGame aBoard aShip ships oneDice dices blackHolesFirstEntrance shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator anotherShip anAccelerationCard aReversePolarityCard cards aDeck |
	numberOfCells := 25.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 5
		          and: 20.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 19.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Elysium' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Axiom' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 20 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	aGame executeTurn.

	shipPositionAfterTheDices := aGame positionOf: anotherShip.
	blackHolesFirstEntrance := aBoard wormsHolesFirstEntrance.

	self
		assert: shipPositionAfterTheDices
		equals: blackHolesFirstEntrance.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoNonReversedCardSpawnerCellThenTheReverseIsntApplied [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard aOverloadCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (CardSpawnerCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (CardSpawnerCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 9.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	aOverloadCard := OverloadCard new.
	cards := OrderedCollection with: aReversePolarityCard with: anAccelerationCard with: aOverloadCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aGame executeTurn.
	aReversePolarityCard selectedCell: 10 of: aGame.
	aGame playCard: aReversePolarityCard from: anotherShip to: aShip.
	aGame executeTurn.

	self assert: (aGame cardManagerOf: aShip) cardsInHand size  equals: 3.
	self assert: (aGame cardManagerOf: aShip) cardsInHand size  equals: 3.
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedWhenItsNotTheShipsTurnThenItFails [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip anAccelerationCard cards aDeck aReversePolarityCard |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (AtomicBombCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	numberOfCells := 12.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 10
		          and: 11.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'The Millenium Falcon' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.
	anAccelerationCard := AccelerationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: anAccelerationCard with: aReversePolarityCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 8 of: aGame.

	self should: [ aGame playCard: aReversePolarityCard from: anotherShip to: aShip. ]  
	raise: Error  
	withMessageText: 'You can only play this card when its your turn'.
]
