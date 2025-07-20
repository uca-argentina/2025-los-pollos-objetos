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
CancellationCardTest >> testWhenACancellationCardIsUsedInAReversePolarityCardThenTheEffectDisappears [

	| aGame aBoard aShip ships oneDice dices numberOfCells cells anotherShip aCancellationCard cards aDeck aReversePolarityCard aOverloadCard |
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
	aCancellationCard := CancellationCard new.
	aReversePolarityCard := ReversePolarityCard new.
	aOverloadCard := OverloadCard new.
	cards := OrderedCollection with: aReversePolarityCard with: aCancellationCard with: aOverloadCard.
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
	aCancellationCard selectedCard: aReversePolarityCard.
	aGame playCard: aCancellationCard from: aShip to: anotherShip.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 1.
	self assert: (aGame positionOf: anotherShip) equals: 1.
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

	cards := OrderedCollection with: anAccelerationCard with: anCancellationCard.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.

	anotherShipsCardsBeforePlay := (aGame shipCardsInHand: anotherShip ).
	anCancellationCard selectedCard: anAccelerationCard.		
	aGame playCard: anCancellationCard from: anotherShip to: aShip.

	self assert: (aGame shipCardsInHand: anotherShip ) equals: (anotherShipsCardsBeforePlay - 1).
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAAccelerationCardThenTheEffectDisappears [

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
	anCancellationCard selectedCard: anAccelerationCard.
	aGame playCard: anCancellationCard from: anotherShip to: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAAccelerationCardThenTheEffectDisappearsOnlyOnce [

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

	cards := OrderedCollection with: anAccelerationCard with: anotherAccelerationCard with: anCancellationCard.

	aDeck := AChargedDeck cards: cards withNShips: (ships size) .
	"self assert: (aDeck cards isEmpty) not."

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.
	aGame playCard: anotherAccelerationCard from: aShip to: anotherShip.
	anCancellationCard selectedCard: anAccelerationCard.
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
		aCancellationCard.
	}.
	aDeck := AChargedDeck cards: cards withNShips: (ships size).

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	aGame executeTurn.

	self assert: (aGame isAnAlly: aShip of: anotherShip).

	aCancellationCard selectedCard: anAlliancenCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self deny: (aGame isAnAlly: aShip of: anotherShip).
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAAllyCardThenTheEffectDisappearsOnlyOnThatAlliance [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck aCancellationCard anAllianceCard oneMoreShip anotherAllianceCard |
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
	oneMoreShip := Ship named: 'The Batwing' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	ships add: oneMoreShip.
	
	anAllianceCard := AllianceCard new.
	anotherAllianceCard := AllianceCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection withAll: {
		anAllianceCard.
		anotherAllianceCard.
		aCancellationCard.
	}.
	aDeck := AChargedDeck cards: cards withNShips: (ships size).

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAllianceCard from: aShip to: anotherShip.
	aGame playCard: anotherAllianceCard from: aShip to: oneMoreShip.
	aGame executeTurn.

	self assert: (aGame isAnAlly: aShip of: anotherShip).
	self assert: (aGame isAnAlly: aShip of: oneMoreShip).

	aCancellationCard selectedCard: anAllianceCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self deny: (aGame isAnAlly: aShip of: anotherShip).
	self assert: (aGame isAnAlly: aShip of: oneMoreShip).
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnACancellationCardThenTheCancellationIsCancelledAndThePreviousCancelledEffectIsEffected [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard anCancellationCard anotherCancellationCard |
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
	anotherCancellationCard := AccelerationCard new.
	anCancellationCard := CancellationCard new.
	cards := OrderedCollection with: anAccelerationCard with: anotherCancellationCard with: anCancellationCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.
	anCancellationCard selectedCard: anAccelerationCard.
	aGame playCard: anCancellationCard from: anotherShip to: aShip.
	anCancellationCard selectedCard: anotherCancellationCard.
	aGame playCard: anotherCancellationCard from: aShip to: anotherShip.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5.
	self assert: (aGame positionOf: anotherShip) equals: 5.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAOneOverloadCardButTwoWereUsedThenTheEffectDisappearsOnlyOnce [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard aCancellationCard anotherOverloadCard |
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard := OverloadCard new.
	anotherOverloadCard := OverloadCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection with: anOverloadCard with: anotherOverloadCard with: aCancellationCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip.
	aGame playCard: anotherOverloadCard from: aShip to: anotherShip.
	aCancellationCard selectedCard: anOverloadCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.

	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5.
	self assert: (aGame positionOf: anotherShip) equals: 3.
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
	cards := OrderedCollection with: anOverloadCard with: aCancellationCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size) .

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

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
	cards := OrderedCollection with: anOverloadCard with: aCancellationCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size).

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip.
	aCancellationCard selectedCard: anOverloadCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnAReDoCardThenTheEffectDisappears [

		| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells cards aDeck  anAccelerationCard aRedoCard aCancellationCard cells |
	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (CardSpawnerCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
	cells add: (NormalCell initializeCellOn: 8).
	cells add: (NormalCell initializeCellOn: 9).
	cells add: (NormalCell initializeCellOn: 10).
	cells add: (NormalCell initializeCellOn: 11).
	cells add: (NormalCell initializeCellOn: 12).
	cells add: (NormalCell initializeCellOn: 13).
	cells add: (NormalCell initializeCellOn: 14).
	numberOfCells := 14.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          whichAre: cells
		          andAWormHoleBetweenCells: 12
		          and: 13.
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAccelerationCard:= AccelerationCard new.
	aRedoCard := ReDoCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection with: anAccelerationCard with: aRedoCard with: aCancellationCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size).

	aGame := SpaceShipGame
		         completedAtLap: 3
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: anotherShip.
	aGame executeTurn.
	aGame executeTurn.
	aGame playCard: aRedoCard from: aShip to: anotherShip.
	aGame skipTurnFor: aShip.
	aGame skipTurnFor: anotherShip.
	aCancellationCard selectedCard: aRedoCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 10.
	self assert: (aGame positionOf: anotherShip) equals: 10.
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipUsesCancellationCardOnARepeatCardThenTheEffectDisappears [

	| aGame aBoard aShip ships oneDice dices anotherShip numberOfCells cells aRepeatCard cards aDeck aCancellationCard |
	
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

	aRepeatCard := RepeatCard new.
	aCancellationCard := CancellationCard new.
	cards := OrderedCollection with: aRepeatCard with: aCancellationCard.
	aDeck := AChargedDeck cards: cards withNShips: (ships size).

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
	aCancellationCard selectedCard: aRepeatCard.
	aGame playCard: aCancellationCard from: anotherShip to: aShip.

	self assert: (aGame positionOf: anotherShip) equals: 2.
]
