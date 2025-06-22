Class {
	#name : 'OverloadCardTest',
	#superclass : 'CardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
OverloadCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
OverloadCardTest >> testWhenAShipUsesOverloadCardThenTheAnotherShipThrowDecreaseByTwo [

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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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
OverloadCardTest >> testWhenAShipUsesOverloadCardWhenItsNotHisTurnThenIsInvalid [

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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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
OverloadCardTest >> testWhenAnOverloadCardIsUsedThenItsEliminatedFromTheHand [

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
		
	oneDice := AChargedDice withATotalNumberOfFacesOf: 3.
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
		
	
		
	self assert: (aGame shipCardsInHand: aShip) equals: 2.
		
	aGame playCard: anOverloadCard from: aShip to: anotherShip .
	
	aGame executeTurn.

	self assert: (aGame shipCardsInHand: aShip) equals: 1.



	


]
