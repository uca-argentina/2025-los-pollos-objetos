Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAReversePolarityCardIsUsedAndThatShipFallsIntoAAtomicBombThenTheNoShipsAreAffectedByTheAtomicBomb [

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
	self assert: (aGame positionOf: anotherShip) equals: 8.
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
		          and: 9.
	
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
