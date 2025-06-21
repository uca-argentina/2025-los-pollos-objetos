Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
CardTest >> testWhenAShipDisableAllianceCardThenBothShipsHaveTheNilAlliance [
	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck   anAlliancenCard |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAlliancenCard:= AllianceCard new.
	cards := OrderedCollection with: anAlliancenCard with: anAlliancenCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.

	self assert: (aShip haveAllianceWith) equals: anotherShip.
	self assert: (anotherShip haveAllianceWith) equals: aShip .
	
	aGame disableCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aShip haveAllianceWith) equals: nil.
	self assert: (anotherShip haveAllianceWith) equals: nil .

]

{ #category : 'tests' }
CardTest >> testWhenAShipInAnAllianceHaveNotEnoughtFuelToPlayThenTheAllyGivesFuel [
	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck   anAlliancenCard |
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
		          andAWormHoleBetweenCells: 8
		          and: 9.
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAlliancenCard:= AllianceCard new.
	cards := OrderedCollection with: anAlliancenCard with: anAlliancenCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	aGame skipTurnFor: anotherShip .
	aGame executeTurn.

	self assert: (aGame positionOf: aShip ) equals: 7.
	

]

{ #category : 'tests' }
CardTest >> testWhenAShipUsesAccelerationCardThenBothShipsMovesOneCellForward [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  anAccelerationCard |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAccelerationCard:= AccelerationCard new.
	cards := OrderedCollection with: anAccelerationCard with: anAccelerationCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAccelerationCard from: aShip to: 'everyone'.
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 5.
	self assert: (aGame positionOf: anotherShip) equals: 5.
]

{ #category : 'tests' }
CardTest >> testWhenAShipUsesAllianceCardThenBothShipsHaveTheAlliance [
	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck   anAlliancenCard |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAlliancenCard:= AllianceCard new.
	cards := OrderedCollection with: anAlliancenCard with: anAlliancenCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.

	self assert: (aShip haveAllianceWith) equals: anotherShip.
	self assert: (anotherShip haveAllianceWith) equals: aShip .

]

{ #category : 'tests' }
CardTest >> testWhenAShipUsesCancelattionCardOnAAcelerationCardThenTheEffectDisappear [

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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAccelerationCard:= AccelerationCard new.
	anCancelattionCard:= CancellationCard new.
	cards := OrderedCollection with: anAccelerationCard with: anCancelattionCard.
	aDeck := Deck with: cards.

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
CardTest >> testWhenAShipUsesCancelattionCardOnANonCardPlayThenItsFailed [

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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
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

{ #category : 'tests' }
CardTest >> testWhenAShipUsesOverloadCardThenTheAnotherShipThrowDecreaseByTwo [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard:= OverloadCard new.
	cards := OrderedCollection with: anOverloadCard with: anOverloadCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 2.
]

{ #category : 'tests' }
CardTest >> testWhenAShipUsesOverloadCardWhenItsNotHisTurnThenIsInvalid [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck anOverloadCard |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anOverloadCard:= OverloadCard new.
	cards := OrderedCollection with: anOverloadCard with: anOverloadCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	
	
	aGame executeTurn.
	
		 self
        should: [aGame playCard: anOverloadCard from: aShip to: anotherShip]
        raise: Error
        withMessageText: 'You can only play this card when its your turn'.



]

{ #category : 'tests' }
CardTest >> testWhenAnAllianceHaveNotEnoughtFuelToPlayThenTheShipsArePenalize [
	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck   anAlliancenCard |
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
		          andAWormHoleBetweenCells: 8
		          and: 9.
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	anAlliancenCard:= AllianceCard new.
	cards := OrderedCollection with: anAlliancenCard with: anAlliancenCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip ) equals: 1.
	self assert: (aGame positionOf: anotherShip ) equals: 1.
	

]

{ #category : 'tests' }
CardTest >> testWhenOneShipStartsWithTwoCards [

	| ships aShip aBoard oneDice dices aGame numberOfCells someProbabilities aCellGenerator cards aDeck |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	
	cards := OrderedCollection with: 'card1' with: 'card2'.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	self assert: (aGame cardManagerOf: aShip) cardsInHand size  equals: 2.

]

{ #category : 'tests' }
CardTest >> testWhenTwoShipsStartWithTwoCards [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck |
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
		
	oneDice := ChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	
	
	cards := OrderedCollection with: 'card1' with: 'card2'.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.

	self assert: (aGame cardManagerOf: aShip) cardsInHand size  equals: 2.
	self assert: (aGame cardManagerOf: anotherShip) cardsInHand size equals: 2.
]
