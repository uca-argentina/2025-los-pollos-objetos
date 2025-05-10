Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedThenItHasAName [

	| aGame aBoard aShip anotherShip ships oneDice anotherDice dices aBoardBuilder |
	
	"aGame := Game new."
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 10.
	aBoardBuilder withBlackHoleFrom: 2 to: 6.
	aBoard := aBoardBuilder build.

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

	| aGame aBoard aShip anotherShip ships oneDice anotherDice dices aBoardBuilder |
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 10.
	aBoardBuilder withBlackHoleFrom: 2 to: 6.
	aBoard := aBoardBuilder build.

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
GameTest >> testWhenGameIsStartedThenItSuccesfullyStarts [

	| aGame aBoard aShip anotherShip ships oneDice anotherDice dices aBoardBuilder |
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 10.
	aBoardBuilder withBlackHoleFrom: 2 to: 6.
	aBoard := aBoardBuilder build.

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
GameTest >> testWhenOneShipGetsToTheBlackHolesFirstEntranceThenItIsForwardedToTheSecondEntranceOfTheBlackHole [

	| aGame aBoard aShip  ships oneDice  dices newPosition positionAfterDetermination blackHolesSecondEntrance |
	
	aBoard := ThreeCellsBoardWithOneBlackHole withThreeCellsAndOneBlackHole. 

	aShip := Ship named: 'Serenity'.
	ships := OrderedCollection with: aShip.

	oneDice := OneFaceDice withOneFace. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Galactico'
		with: aBoard
		and: dices
		and: ships.
		
	aShip throw: dices.
	newPosition := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip.
	positionAfterDetermination := aShip position.
	blackHolesSecondEntrance := aBoard blackHolesSecondEntrance.
	
	self assert: positionAfterDetermination equals: blackHolesSecondEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheBlackHolesSecondEntranceThenItIsForwardedToTheFirstEntranceOfTheBlackHole [

	| aGame aBoard aShip  ships oneDice  dices newPosition positionAfterDetermination blackHolesFirstEntrance |
	
	aBoard := ThreeCellsBoardWithOneBlackHole withThreeCellsAndOneBlackHole. 

	aShip := Ship named: 'Elysium'.
	ships := OrderedCollection with: aShip.

	oneDice := TwoFacesDiceTrickedToAlwaysReturnTwoWhenThrown withTwoFaces. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Galactico'
		with: aBoard
		and: dices
		and: ships.
		
	aShip throw: dices.
	newPosition := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip.
	positionAfterDetermination := aShip position.
	blackHolesFirstEntrance := aBoard blackHolesFirstEntrance.
	
	self assert: positionAfterDetermination equals: blackHolesFirstEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWinningCellThenTheGameFinishes [

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
	
	"self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'The game has ended, you won!'"
	self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'Apolo won the Game!'
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWinningCellThenYouCanKnowWhichShipWon [

	| aGame aBoard aShip  ships oneDice  dices newPosition |
	
	aBoard := OneCellBoard withOneCell. 

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := OneFaceDice withOneFace. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Asombroso'
		with: aBoard
		and: dices
		and: ships.
		
	aShip throw: dices.
	newPosition := aShip position. 
	
	self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'Venture won the Game!'
]

{ #category : 'tests' }
GameTest >> testWhenOneShipWinsThenYouCanKnowThePositionOfEachShipInTheGame [

	| aGame aBoard aShip  ships oneDice  dices newPosition anotherShip |
	
	aBoard := OneCellBoard withOneCell. 

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Axiom'.
	ships := OrderedCollection with: aShip with: anotherShip.

	oneDice := OneFaceDice withOneFace. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Maravilloso'
		with: aBoard
		and: dices
		and: ships.
		
	aShip throw: dices.
	newPosition := aShip position. 
	
	self assert: (aShip position) equals: 1.
	self assert: (anotherShip position) equals: 0.
]
