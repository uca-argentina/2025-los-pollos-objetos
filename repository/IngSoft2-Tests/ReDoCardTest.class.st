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
ReDoCardTest >> testWhenAShipUsesAReDoCardAfterUsingOtherReDoCardBeforeOverloadCardThenTheOthersShipThrowIsDecreasedByTwo [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard aRedoCard anotherRedoCard |
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
	
	anOverloadCard := OverloadCard new.
	aRedoCard := ReDoCard new.
	anotherRedoCard := ReDoCard new.
	
	cards := OrderedCollection withAll: {
		anOverloadCard.
		aRedoCard.
		anotherRedoCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	aGame playCard: aRedoCard from: aShip to: anotherShip .
	aGame addASpecificCard: anotherRedoCard toShip: aShip.
	aGame playCard: anotherRedoCard from: aShip to: anotherShip .

	aGame executeTurn.
	aGame executeTurn.
	
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 1.
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
