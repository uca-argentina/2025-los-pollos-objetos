Class {
	#name : 'ReDoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReDoCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAReDoCardIsUsedAfterAReversePolarityCardAndThatShipFallsIntoAAtomicBombThenTheReversalIsReversed [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip aReDoCard cards aDeck aReversePolarityCard |
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
	aReDoCard := ReDoCard new.
	aReversePolarityCard := ReversePolarityCard new.
	cards := OrderedCollection with: aReversePolarityCard with: aReDoCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	aGame := SpaceShipGame
		         completedAtLap: 2
		         with: aBoard
		         and: dices
		         and: ships
					and: aDeck.

	aReversePolarityCard selectedCell: 7 of: aGame.
	aGame playCard: aReversePolarityCard from: aShip to: anotherShip.
	aGame playCard: aReDoCard from: aShip to: anotherShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesAReDoCardAfterAAccelerationCardThenItsRemovedFromItsHand [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck aAccelerationCard anRedoCard |
	numberOfCells := 15.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 14
		          and: 15.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	aAccelerationCard := AccelerationCard new.
	anRedoCard := ReDoCard new.
	
	cards := OrderedCollection withAll: {
		aAccelerationCard.
		anRedoCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: aAccelerationCard from: aShip to: anotherShip .
	aGame playCard: anRedoCard from: aShip to: anotherShip .
	
	self assert: (aGame shipCardsInHand: aShip ) equals: 0.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesAReDoCardAfterAAccelerationCardThenTheAccelerationEffectIsApplied [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck aAccelerationCard anRedoCard |
	numberOfCells := 15.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 14
		          and: 15.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	aAccelerationCard := AccelerationCard new.
	anRedoCard := ReDoCard new.
	
	cards := OrderedCollection withAll: {
		aAccelerationCard.
		anRedoCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: aAccelerationCard from: aShip to: anotherShip .
	aGame playCard: anRedoCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	
	self assert: (aGame positionOf: aShip ) equals: 9.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesAReDoCardThenItsRemovedFromItsHand [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard anRedoCard |
	numberOfCells := 15.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 14
		          and: 15.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard:= OverloadCard new.
	anRedoCard:= ReDoCard new.
	
	cards := OrderedCollection withAll: {
		anOverloadCard.
		anRedoCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	aGame playCard: anRedoCard from: aShip to: anotherShip .
	
	self assert: (aGame shipCardsInHand: aShip ) equals: 0.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesReDoCardAfterAnOverloadCardInADifferentShipThenTheDifferentShipThrowDecreasesByTwo [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard anRedoCard anotherShip2 |
	numberOfCells := 15.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 14
		          and: 15.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	anotherShip2 := Ship named: 'Zorgons Ship II' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	ships add: anotherShip2.
	
	anOverloadCard:= OverloadCard new.
	anRedoCard:= ReDoCard new.
	
	cards := OrderedCollection withAll: {
		anOverloadCard.
		anRedoCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	aGame playCard: anRedoCard from: aShip to: anotherShip2 .

	aGame executeTurn.
	aGame executeTurn.
	aGame executeTurn.
	
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 5.
	self assert: (aGame positionOf: anotherShip2) equals: 5.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesReDoCardAfterAnOverloadCardThenTheAnotherShipThrowDecreasesByTwo [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard anRedoCard |
	numberOfCells := 15.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 14
		          and: 15.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard:= OverloadCard new.
	anRedoCard:= ReDoCard new.
	
	cards := OrderedCollection withAll: {
		anOverloadCard.
		anRedoCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	aGame playCard: anRedoCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	aGame executeTurn.
	
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 3.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesReDoCardAfterNoPlayingCardThenItsFailed [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anRedoCard anotherShip2 |
	numberOfCells := 15.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 14
		          and: 15.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	anotherShip2 := Ship named: 'Zorgons Ship II' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	ships add: anotherShip2.
	
	anRedoCard:= ReDoCard new.
	
	cards := OrderedCollection with: anRedoCard with: anRedoCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	self should: [	aGame playCard: anRedoCard from: aShip to: anotherShip2  ]  
		raise: Error  
		withMessageText: 'Theres no last card play. Invalid ReDo card'.
]

{ #category : 'tests' }
ReDoCardTest >> testWhenAShipUsesTwoReDoCardsAfterUsingAOverloadCardOnASameShipThenTheOthersShipThrowIsDecreasedByFour [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells cells cards aDeck anOverloadCard aRedoCard anotherRedoCard |
	
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
	cells add: (NormalCell initializeCellOn: 11).
	numberOfCells := 11.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 9
		          and: 10.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 6.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip with: anotherShip.
	
	anOverloadCard := OverloadCard new.
	aRedoCard := ReDoCard new.
	anotherRedoCard := ReDoCard new.
	
	cards := OrderedCollection with: anOverloadCard with: aRedoCard with: anotherRedoCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size).

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	aGame playCard: aRedoCard from: aShip to: anotherShip.

	aGame executeTurn.
	aGame playCard: anotherRedoCard from: anotherShip to: anotherShip.
	aGame executeTurn.
	
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 1.
]
