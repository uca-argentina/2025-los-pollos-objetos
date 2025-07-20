Class {
	#name : 'RepeatCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RepeatCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
RepeatCardTest >> testWhenARepeatCardIsUsedAfterAReversePolarityCardAndThatShipFallsIntoAAtomicBombThenTheEffectIsProperlyRepeated [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip aRepeatCard cards aDeck aReversePolarityCard |
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
	aRepeatCard := RepeatCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: aReversePolarityCard with: aRepeatCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 7 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	aGame executeTurn.
	aGame playCard: aRepeatCard from: anotherShip to: aShip.
	
	self assert: (aGame positionOf: aShip) equals: 7.
]

{ #category : 'tests' }
RepeatCardTest >> testWhenARepeatCardIsUsedThenItsEliminatedFromTheHand [

	| aGame aBoard aShip ships oneDice dices anotherShip numberOfCells cells aRepeatCard cards aDeck |
	
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (MoonWalkCell initializeCellOn: 5 withRequiredValue: 1).
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

	aRepeatCard:= RepeatCard new.
	cards := OrderedCollection with: aRepeatCard with: aRepeatCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	aGame executeTurn.
	aGame skipTurnFor: aShip.
	aGame executeTurn.
	aGame skipTurnFor: anotherShip.
	aGame executeTurn.
	
	self assert: (aGame shipCardsInHand: aShip) equals: 2.
	
	aGame playCard: aRepeatCard from: aShip to: anotherShip.
	
	self assert: (aGame shipCardsInHand: aShip) equals: 1.
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipUsesRepeatCardThenBlackHoleLastEffectIsAppliedToAnotherShip [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip aRepeatCard cards aDeck |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (NormalCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (BlackHoleCell initializeCellOn: 10).
	numberOfCells := 10.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 8
		          and: 9.
	
	oneDice := AChargedDice withATotalNumberOfFacesOf: 9.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.

	aRepeatCard:= RepeatCard new.
	cards := OrderedCollection with: aRepeatCard with: aRepeatCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	aGame executeTurn.
	aGame executeTurn.
	
	aGame playCard: aRepeatCard from: aShip to: anotherShip.

	self assert: (aGame positionOf: aShip) equals: 6. 
	self assert: (aGame positionOf: anotherShip) equals: 2. 
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipUsesRepeatCardThenMoonWalkLastEffectIsAppliedToAnotherShip [

	| aGame aBoard aShip ships oneDice dices anotherShip numberOfCells cells aRepeatCard cards aDeck |
	
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (MoonWalkCell initializeCellOn: 5 withRequiredValue: 1).
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

	aRepeatCard:= RepeatCard new.
	cards := OrderedCollection with: aRepeatCard with: aRepeatCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	aGame executeTurn.
	aGame skipTurnFor: aShip.
	aGame executeTurn.
	aGame skipTurnFor: anotherShip.
	aGame executeTurn.
	
	self assert: (aGame positionOf: aShip) equals: 5.
	self assert: (aGame positionOf: anotherShip) equals: 2.
	
	aGame playCard: aRepeatCard from: aShip to: anotherShip.
	
	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 2.
]
