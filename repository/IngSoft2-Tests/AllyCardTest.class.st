Class {
	#name : 'AllyCardTest',
	#superclass : 'CardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AllyCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipDisableAllianceCardThenBothShipsHaveTheNilAlliance [
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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

	self assert: ((aShip inAllianceWith) includes: anotherShip).
	self assert: ((anotherShip inAllianceWith) includes: aShip).

	
	aGame disableCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aShip inAllianceWith) isEmpty.
	self assert: (anotherShip inAllianceWith) isEmpty.

]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipInAnAllianceHaveNotEnoughtFuelToPlayAndTheFirstAlianceNeitherThenTheSecondAllyGivesFuel [
	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck   anAlliancenCard anotherSecondShip |
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	anotherSecondShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	ships add: anotherSecondShip .
	
	anAlliancenCard:= AllianceCard new.
	cards := OrderedCollection with: anAlliancenCard with: anAlliancenCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	aGame playCard: anAlliancenCard from: aShip to: anotherSecondShip .
	
	aGame executeTurn.
	aGame executeTurn.
	
	"aGame executeTurn."
	aGame skipTurnFor: anotherSecondShip .
	
	aGame executeTurn.

	self assert: (aGame positionOf: aShip ) equals: 7.
	self assert: (aGame positionOf: anotherShip ) equals: 4.
	self assert: (aGame positionOf: anotherSecondShip ) equals: 1.
	

]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipInAnAllianceHaveNotEnoughtFuelToPlayThenTheFirstAllyGivesFuel [
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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
AllyCardTest >> testWhenAShipUsesAllianceCardThenBothShipsHaveTheAlliance [
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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

	self assert: ((aShip inAllianceWith) includes: anotherShip).
	self assert: ((anotherShip inAllianceWith) includes: aShip).


]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipUsesAllyCardWhenItsNotHisTurnThenIsInvalid [

	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck  aAllyCard |
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
	
	aAllyCard:= AllianceCard new.
	cards := OrderedCollection with: aAllyCard with: aAllyCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame executeTurn.
	
	self should: [aGame playCard: aAllyCard from: aShip to: 'everyone'. ] 
	raise: Error  
	withMessageText: 'You can only play this card when its your turn'.
]

{ #category : 'tests' }
AllyCardTest >> testWhenAnAllianceHaveNotEnoughtFuelToPlayThenTheShipsArePenalize [
	| ships aShip aBoard oneDice dices aGame anotherShip numberOfCells someProbabilities aCellGenerator cards aDeck   anAlliancenCard anotherShip2 |
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
	dices := OrderedCollection with: oneDice.
	
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Zorgons Ship' withAChargeBasedOn: dices.
	anotherShip2 := Ship named: 'Zorgons  II Ship' withAChargeBasedOn: dices. 
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.
	ships add: anotherShip2.
	
	anAlliancenCard:= AllianceCard new.
	cards := OrderedCollection with: anAlliancenCard with: anAlliancenCard.
	aDeck := Deck with: cards.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships and: aDeck.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	aGame playCard: anAlliancenCard from: aShip to: anotherShip2 .
	
	aGame executeTurn.
	aGame executeTurn.
	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame positionOf: aShip ) equals: 1.
	self assert: (aGame positionOf: anotherShip ) equals: 1.
	self assert: (aGame positionOf: anotherShip2 ) equals: 1.
	

]

{ #category : 'tests' }
AllyCardTest >> testWhenAnAllyCardIsUsedThenItsEliminatedFromTheHand [
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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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
		
	self assert: (aGame shipCardsInHand: aShip) equals: 2.
		
	aGame playCard: anAlliancenCard from: aShip to: anotherShip .
	
	aGame executeTurn.

	self assert: (aGame shipCardsInHand: aShip) equals: 1.



	


]
