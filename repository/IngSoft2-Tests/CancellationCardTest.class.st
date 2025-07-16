Class {
	#name : 'CancellationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancellationCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedThenItsEliminatedFromTheHand [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard anCancellationCard anotherShipsCardsBeforePlay |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 7
		          and: 9.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAccelerationCard := AccelerationCard new.
	anCancellationCard := CancellationCard new.

	cards := OrderedCollection withAll: {
		anAccelerationCard.
		anCancellationCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.

	anotherShipsCardsBeforePlay := (aGame shipCardsInHand: anotherShip ).
	anCancellationCard selectedCard: AccelerationCard.		
	aGame playCard: anCancellationCard from: anotherShip to: aShip.

	self assert: (aGame shipCardsInHand: anotherShip ) equals: (anotherShipsCardsBeforePlay - 1).
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAAcelerationCardThenTheEffectDisappears [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard anCancellationCard |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 7
		          and: 9.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAccelerationCard := AccelerationCard new.
	anCancellationCard := CancellationCard new.

	cards := OrderedCollection with: anAccelerationCard with: anCancellationCard.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.
	anCancellationCard selectedCard: AccelerationCard.
	aGame playCard: anCancellationCard from: anotherShip to: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAAcelerationCardThenTheEffectDisappearsOnlyOnce [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard anCancellationCard anotherAccelerationCard |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 7
		          and: 9.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAccelerationCard := AccelerationCard new.
	anotherAccelerationCard := AccelerationCard new.
	anCancellationCard := CancellationCard new.

	cards := OrderedCollection withAll: {
		anAccelerationCard.
		anCancellationCard.
		anotherAccelerationCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.
	aGame addASpecificCard: anotherAccelerationCard toShip: aShip.
	aGame playCard: anotherAccelerationCard from: aShip to: anotherShip.
	anCancellationCard selectedCard: AccelerationCard.
	aGame addASpecificCard: anCancellationCard toShip: anotherShip.
	aGame playCard: anCancellationCard from: anotherShip to: aShip.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5.
	self assert: (aGame positionOf: anotherShip) equals: 5.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAAllyCardThenTheEffectDisappears [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck aCancellationCard anAlliancenCard |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 7
		          and: 9.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAlliancenCard := AllianceCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection withAll: {
		anAlliancenCard.
	}.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	aGame executeTurn.

	self assert: ((aGame alliesOf: aShip) includes: anotherShip).
	self assert: ((aGame alliesOf: anotherShip) includes: aShip).

	aGame addASpecificCard: aCancellationCard toShip: anotherShip.
	aCancellationCard selectedCard: aCancellationCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame alliesOf: aShip) isEmpty.
	self assert: (aGame alliesOf: anotherShip) isEmpty.

]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAOverloadCardNotPlayedThenShipsMoveAccordinlgy [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard aCancellationCard |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 7
		          and: 9.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard := OverloadCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection with: anOverloadCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	aGame addASpecificCard: aCancellationCard toShip: anotherShip.
	aCancellationCard selectedCard: anOverloadCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAOverloadCardThenTheEffectDisappears [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard aCancellationCard |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 7
		          and: 9.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard := OverloadCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection with: anOverloadCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip.
	aGame addASpecificCard: aCancellationCard toShip: anotherShip.
	aCancellationCard selectedCard: anOverloadCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]
