Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedThenItHasAName [

	| aGame |
	aGame := Game new.
	
	self assert: (aGame name) equals: 'Juego 1'.
	
	
	
	
	
	
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
