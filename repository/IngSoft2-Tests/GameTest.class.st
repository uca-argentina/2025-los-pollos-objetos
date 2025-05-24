Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErroClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErroClass
		withExceptionDo: [ :error | self assert: (error messageText ) equals: errorMessage ]
	
]

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
GameTest >> testWhenGameIsStartedThenItSuccesfullyStarts [

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
GameTest >> testWhenOneGameIsInitializedWithAMaximumThrowOfFiveThenShipsHaveTenUnitsOfFuel [
    | aGame aBoard aShip  ships oneDice  dices |
    aBoard := Board withATotalNumberOfCellsOf: 20 andABlackHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 5. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        named: 'Juego Galactico'
        with: aBoard
        and: dices
        and: ships.

    self assert: aShip currentCharge equals: 10.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheBlackHolesFirstEntranceThenItIsForwardedToTheSecondEntranceOfTheBlackHole [

	| aGame aBoard aShip  ships oneDice  dices   blackHolesSecondEntrance shipPositionAfterTheDices positionAfterDeterminingIfItFallsIntoABlackHole |
	
	aBoard := Board withATotalNumberOfCellsOf: 25 andABlackHoleBetweenCells: 5 and: 20.

	aShip := Ship named: 'Serenity'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Galactico'
		with: aBoard
		and: dices
		and: ships.
		
	"aShip throw: dices."
	aGame throwDiceFor: aShip.
	
	shipPositionAfterTheDices := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.
	
	positionAfterDeterminingIfItFallsIntoABlackHole := aShip position.
	blackHolesSecondEntrance := aBoard blackHolesSecondEntrance.
	
	self assert: positionAfterDeterminingIfItFallsIntoABlackHole equals: blackHolesSecondEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheBlackHolesSecondEntranceThenItIsForwardedToTheFirstEntranceOfTheBlackHole [

	| aGame aBoard aShip  ships oneDice  dices  blackHolesFirstEntrance shipPositionAfterTheDices positionAfterDeterminingIfItFallsIntoABlackHole  |
	aBoard := Board withATotalNumberOfCellsOf: 25 andABlackHoleBetweenCells: 5 and: 20.

	aShip := Ship named: 'Elysium'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 20. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Galactico'
		with: aBoard
		and: dices
		and: ships.
			
	"aShip throw: dices."
	aGame throwDiceFor: aShip.
	
	shipPositionAfterTheDices := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.
	
	positionAfterDeterminingIfItFallsIntoABlackHole := aShip position.	
	
	blackHolesFirstEntrance := aBoard blackHolesFirstEntrance.
	
	self assert: positionAfterDeterminingIfItFallsIntoABlackHole equals: blackHolesFirstEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWinningCellThenTheGameFinishes [

	| aGame aBoard aShip  ships oneDice  dices newPosition |
	aBoard := Board withATotalNumberOfCellsOf: 6 andABlackHoleBetweenCells: 2 and: 5. 

	aShip := Ship named: 'Apolo'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego 2'
		with: aBoard
		and: dices
		and: ships.
		
	"aShip throw: dices."
	aGame throwDiceFor: aShip.
	newPosition := aShip position. 
	
	"self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'The game has ended, you won!'"
	self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'Apolo won the Game!'
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWinningCellThenYouCanKnowWhichShipWon [

	| aGame aBoard aShip  ships oneDice  dices newPosition |
	aBoard := Board withATotalNumberOfCellsOf: 6 andABlackHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		named: 'Juego Asombroso'
		with: aBoard
		and: dices
		and: ships.
		
	aGame throwDiceFor: aShip.
	newPosition := aShip position. 
	
	self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'Venture won the Game!'
]

{ #category : 'tests' }
GameTest >> testWhenOneShipHasTwoUnitsOfFuelAndMakesOneMoveThenItConsumesOneUnitOfFuel [
    | aGame aBoard aShip  ships oneDice  dices |
    aBoard := Board withATotalNumberOfCellsOf: 20 andABlackHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 1. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        named: 'Juego Galactico'
        with: aBoard
        and: dices
        and: ships.

    aGame throwDiceFor: aShip.

    self assert: aShip currentCharge equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMakesOneMoveThenItIsForwardedToTheNewPosition [
    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition |
    aBoard := Board withATotalNumberOfCellsOf: 20 andABlackHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        named: 'Juego Galactico'
        with: aBoard
        and: dices
        and: ships.

    intialShipPosition := aShip position.

    aGame throwDiceFor: aShip.

    self deny: aShip position equals: intialShipPosition.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipWinsThenYouCanKnowThePositionOfEachShipInTheGame [ 

    | aGame aBoard aShip  ships oneDice  dices  anotherShip shipPositionAfterTheDices |

    aBoard := Board withATotalNumberOfCellsOf: 20 andABlackHoleBetweenCells: 16 and: 20.

    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 16.  
    dices := OrderedCollection with: oneDice.

    aGame := Game
        named: 'Juego Maravilloso'
        with: aBoard
        and: dices
        and: ships.

	aGame throwDiceFor: aShip.
	shipPositionAfterTheDices := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.

    self assert: (aShip position) equals: 20.
    self assert: (anotherShip position) equals: 0.
]
