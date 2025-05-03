Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedThenItHasAName [

	| aGame aBoard aShip anotherShip ships oneDice anotherDice dices |
	
	"aGame := Game new."
	
	aBoard := Board
		          withATotalNumberOfCellsOf: 10
		          andABlackHoleBetweenCells: 2
		          and: 6.

	aShip := Ship named: 'Executor'.
	anotherShip := Ship named: 'Axiom'.
	ships := OrderedCollection with: aShip with: anotherShip.

	oneDice := Dice withATotalNumberOfFacesOf: 6.
	anotherDice := Dice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice with: anotherDice.

	aGame := Game
		         named: 'Juego 1'
		         with: aBoard
		         and: dices
		         and: ships.

	self assert: aGame name equals: 'Juego 1'
]

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedWithAllThePiecesThenIsSuccesfullyCreated [

	| aGame aBoard aShip anotherShip ships oneDice anotherDice dices |
	aBoard := Board
		          withATotalNumberOfCellsOf: 10
		          andABlackHoleBetweenCells: 2
		          and: 6.

	aShip := Ship named: 'Executor'.
	anotherShip := Ship named: 'Axiom'.
	ships := OrderedCollection with: aShip with: anotherShip.

	oneDice := Dice withATotalNumberOfFacesOf: 6.
	anotherDice := Dice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice with: anotherDice.

	aGame := Game
		named: 'Juego 2'
		with: aBoard
		and: dices
		and: ships.

	self assert: aGame name equals: 'Juego 2'
]

{ #category : 'tests' }
GameTest >> testWhenGameIsStartedThenItIsSuccesfullyStart [

	| aGame aBoard aShip anotherShip ships oneDice anotherDice dices |
	aBoard := Board
		          withATotalNumberOfCellsOf: 10
		          andABlackHoleBetweenCells: 2
		          and: 6.

	aShip := Ship named: 'Executor'.
	anotherShip := Ship named: 'Axiom'.
	ships := OrderedCollection with: aShip with: anotherShip.

	oneDice := Dice withATotalNumberOfFacesOf: 6.
	anotherDice := Dice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice with: anotherDice.

	aGame := Game
		named: 'Juego 2'
		with: aBoard
		and: dices
		and: ships.
		

	self assert: (aGame start) equals: 'The Game Has Started'
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetToTheWinningCellThenItFinishes [

	| aGame aBoard aShip  ships oneDice  dices newPosition |
	aBoard := OneCellBoard withOneCell. 

	aShip := Ship named: 'Apolo'.
	ships := OrderedCollection with: aShip.

	oneDice := OneFaceDice withOneFace. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego 2'
		with: aBoard
		and: dices
		and: ships.
		
	aShip throw: dices.
	
	newPosition := aShip position. 
	
	self assert: (aGame checkResultOfTheThrow: newPosition) equals: 'The game has ended, you won!'
]
