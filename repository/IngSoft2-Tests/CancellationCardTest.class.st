Class {
	#name : 'CancellationCardTest',
	#superclass : 'CardTest',
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

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard anCancelattionCard |
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
	anCancelattionCard := CancellationCard new.

	cards := OrderedCollection withAll: {
		anAccelerationCard.
		anCancelattionCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."


	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: 'everyone'.
	
	aGame executeTurn.
	aGame executeTurn.
	
	aGame executeTurn.
	anCancelattionCard selectedCard: AccelerationCard.
	
	self assert: (aGame shipCardsInHand: anotherShip ) equals: 2.
	
	aGame playCard: anCancelattionCard from: anotherShip to: 'everyone'.
	aGame executeTurn.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame shipCardsInHand: anotherShip ) equals: 1.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancelattionCardOnAAcelerationCardThenTheEffectDisappear [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard anCancelattionCard |
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
	anCancelattionCard := CancellationCard new.

	cards := OrderedCollection withAll: {
		anAccelerationCard.
		anCancelattionCard.
	}.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."


	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: 'everyone'.
	
	aGame executeTurn.
	aGame executeTurn.
	
	aGame executeTurn.
	anCancelattionCard selectedCard: AccelerationCard.
	aGame playCard: anCancelattionCard from: anotherShip to: 'everyone'.
	aGame executeTurn.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancelattionCardOnANonCardPlayThenItsFailed [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anCancelattionCard |
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
	

	anCancelattionCard:= CancellationCard new.
	cards := OrderedCollection with: anCancelattionCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	
	aGame executeTurn.
	anCancelattionCard selectedCard: AccelerationCard.
	self
  		should: [ aGame playCard: anCancelattionCard from: anotherShip to: 'everyone' ]
  		raise: Error
  		withMessageText: 'No hay ninguna carta activa de ese tipo.'.

]
