Class {
	#name : 'CardSpawnerCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardSpawnerCellTest >> testWhenShipArrivesToCardSpawnerCellThenShipPickACard [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells cards aDeck anotherShip |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add:
		(CardSpawnerCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	numberOfCells := 7.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 6
		          and: 7.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Axiom' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with:anotherShip .

	cards := OrderedCollection with: 'card1' with: 'card2'.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	aGame executeTurn.

	self assert: (aGame cardManagerOf: aShip) cardsInHand size  equals: 3.
	self assert: (aGame cardManagerOf: anotherShip ) cardsInHand size  equals: 2.
]
