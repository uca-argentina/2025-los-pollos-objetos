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
GameTest >> testWhenAShipIsPenalizeWithTwoMovesThenItsIncludedInThePenalizationsDictionary [

	| ships aShip  aBoard oneDice dices aGame  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame penalize: aShip withTurns: 2.

	self assert: (aGame penaltyFor: aShip) equals: 2.
]

{ #category : 'tests' }
GameTest >> testWhenAShipIsPenalizedThenTheFuelIsRestoredAfterLosingItsTurn [

	| ships aShip  aBoard oneDice dices aGame  anotherShip  fuelBeforePenalization fuelAfterPenalization |
	
	aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 1 and: 2.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
	
	aGame executeTurn. 
	aGame executeTurn. 
	
	fuelBeforePenalization := aShip currentFuel .
	
	aGame penalize: aShip withTurns: 1. 
		
	aGame executeTurn. 
	
	fuelAfterPenalization := aShip currentFuel .
	
	self deny: fuelBeforePenalization equals: fuelAfterPenalization 
	
	
]

{ #category : 'tests' }
GameTest >> testWhenAShipIsPenalizedWithANonIntegerThenItFails [

	
	| ships aShip  aBoard oneDice dices aGame  anotherShip  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	self should:[aGame penalize: aShip withTurns: '2']
	raise: Error 
	withMessageText: 'The penalty must be a positive integer.'
	
	
]

{ #category : 'tests' }
GameTest >> testWhenAShipIsPenalizedWithANonPositiveIntegerThenItFails [

	
	| ships aShip  aBoard oneDice dices aGame  anotherShip  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	self should:[aGame penalize: aShip withTurns: -2]
	raise: Error 
	withMessageText: 'The penalty must be a positive integer.'
	
	
]

{ #category : 'tests' }
GameTest >> testWhenAShipRunsOutOfFuelThenItsPenalizedWithTwoTurns [

	| ships aShip  aBoard oneDice dices aGame  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame penaltyFor: aShip) equals: 2.
]

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedThenItHasAWinningLap [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices |

    "aGame := Game new."

    aBoard := Board
                  withATotalNumberOfCellsOf: 10
                  andAWormHoleBetweenCells: 2
                  and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := Game
                 completedAtLap: 1
                 with: aBoard
                 and: dices
                 and: ships.

    self assert: aGame winningLap equals: 1
]

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedWithAllThePiecesThenIsSuccesfullyCreated [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices |

    aBoard := Board
                  withATotalNumberOfCellsOf: 10
                  andAWormHoleBetweenCells: 2
                  and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: aGame winningLap equals: 1
]

{ #category : 'tests' }
GameTest >> testWhenGameIsStartedThenAllShipsAreAtTheFirstCell [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices firstCell |
    aBoard := Board
                  withATotalNumberOfCellsOf: 10
                  andAWormHoleBetweenCells: 2
                  and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	firstCell := aBoard cellNumber: 1.
	
	self assert: (firstCell includes: aShip) equals: true.
	self assert: (firstCell includes: anotherShip) equals: true.
]

{ #category : 'tests' }
GameTest >> testWhenGameIsStartedThenItSuccesfullyStarts [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices |
    aBoard := Board
                  withATotalNumberOfCellsOf: 10
                  andAWormHoleBetweenCells: 2
                  and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: (aGame start) equals: 'The Game Has Started'
]

{ #category : 'tests' }
GameTest >> testWhenOneGameIsInitializedWithAMaximumThrowOfFiveThenAllShipsHaveTenUnitsOfFuel [

    | aGame aBoard aShip  ships oneDice  dices anotherShip |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
	 anotherShip := Ship named: 'The Batwing'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 5. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: aShip currentFuel equals: 10.
	 self assert: anotherShip currentFuel equals: 10.
]

{ #category : 'tests' }
GameTest >> testWhenOneGameIsInitializedWithAMaximumThrowOfFiveThenShipsHaveTenUnitsOfFuel [

    | aGame aBoard aShip  ships oneDice  dices |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 5. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: aShip currentFuel equals: 10.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWinningLapThenTheGameFinishes [

	| aGame aBoard aShip  ships oneDice  dices newPosition |
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5. 

	aShip := Ship named: 'Apolo'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 7. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		completedAtLap: 1
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
GameTest >> testWhenOneShipGetsToTheWinningLapThenYouCanKnowWhichShipWon [

	| aGame aBoard aShip  ships oneDice  dices newPosition |
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 7. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		completedAtLap: 1
		with: aBoard
		and: dices
		and: ships.
		
	aGame throwDiceFor: aShip.
	newPosition := aShip position. 
	
	self assert: (aGame determineTheConsequencesOfTheThrowIn: newPosition forShip: aShip) equals: 'Venture won the Game!'
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWormsHolesFirstEntranceThenItIsForwardedToTheSecondEntranceOfTheWormsHole [

	| aGame aBoard aShip  ships oneDice  dices   blackHolesSecondEntrance shipPositionAfterTheDices positionAfterDeterminingIfItFallsIntoABlackHole |
	
	aBoard := Board withATotalNumberOfCellsOf: 25 andAWormHoleBetweenCells: 5 and: 8.

	aShip := Ship named: 'Serenity'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 4. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		completedAtLap: 1
		with: aBoard
		and: dices
		and: ships.
		
	"aShip throw: dices."
	aGame throwDiceFor: aShip.
	
	shipPositionAfterTheDices := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.
	
	positionAfterDeterminingIfItFallsIntoABlackHole := aShip position.
	blackHolesSecondEntrance := aBoard wormsHolesSecondEntrance.
	
	self assert: positionAfterDeterminingIfItFallsIntoABlackHole equals: blackHolesSecondEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWormsHolesSecondEntranceThenItIsForwardedToTheFirstEntranceOfTheWormHole [

	| aGame aBoard aShip  ships oneDice  dices  blackHolesFirstEntrance shipPositionAfterTheDices positionAfterDeterminingIfItFallsIntoABlackHole  |
	aBoard := Board withATotalNumberOfCellsOf: 25 andAWormHoleBetweenCells: 5 and: 20.

	aShip := Ship named: 'Elysium'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 19. 
	dices := OrderedCollection with: oneDice.

	aGame := Game
		completedAtLap: 1
		with: aBoard
		and: dices
		and: ships.
			
	"aShip throw: dices."
	aGame throwDiceFor: aShip.
	
	shipPositionAfterTheDices := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.
	
	positionAfterDeterminingIfItFallsIntoABlackHole := aShip position.	
	
	blackHolesFirstEntrance := aBoard wormsHolesFirstEntrance.
	
	self assert: positionAfterDeterminingIfItFallsIntoABlackHole equals: blackHolesFirstEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipHasTwoUnitsOfFuelAndMakesOneMoveThenItConsumesOneUnitOfFuel [

    | aGame aBoard aShip  ships oneDice  dices |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 1. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame throwDiceFor: aShip.

    self assert: aShip currentFuel equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMakesOneLapThenItReturnsToTheFirstCell [

    | aGame aBoard aShip  ships oneDice  dices  anotherShip shipPositionAfterTheDices |

    aBoard := Board withATotalNumberOfCellsOf: 10 andAWormHoleBetweenCells: 2 and: 6.

    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 10.  
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame throwDiceFor: aShip.
	shipPositionAfterTheDices := aShip position.

    self assert: (aShip position) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMakesOneMoveThenItIsForwardedToTheNewPosition [

    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    intialShipPosition := aShip position.

    aGame move: aShip to: 2 andConsume: 1.

    self deny: aShip position equals: intialShipPosition.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMovesOnePositionForwardThenItIsInTheNewCell [

    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition secondCell |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 17 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    intialShipPosition := aShip position.

    aGame move: aShip to: 2 andConsume: 1.
	 secondCell := aBoard cellNumber: (aShip position).

    self assert: (secondCell includes: aShip) equals: true.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMovesOnePositionForwardThenItIsNoLongerInThePreviousCell [

    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition firstCell |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 17 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    intialShipPosition := aShip position.

    aGame move: aShip to: 2 andConsume: 1.
	 firstCell := aBoard cellNumber: (aShip lastPosition).

    self deny: (firstCell includes: aShip) equals: true.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipThrowsDiceAndReturnsOneThenItIsForwardedOnePosition [

    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition |
    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
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

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 19.  
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame throwDiceFor: aShip.
	shipPositionAfterTheDices := aShip position. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.

    self assert: (aShip position) equals: 20.
    self assert: (anotherShip position) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenShipDecidesNotToPlayItsTurnThenItsTurnIsSkipped [

	| ships aShip  aBoard oneDice dices aGame  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame skipTurnFor: aShip.

	self assert: (aGame penaltyFor: aShip) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenTheCurrentShipHasTwoPenalizationsThenItLosesTwoTurns [

	| ships aShip  aBoard oneDice dices aGame  anotherShip actualShipInGame |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	aGame penalize: aShip withTurns: 2.
	
	aGame executeTurn. 
	actualShipInGame:= aGame executeTurn. 

	self assert: (actualShipInGame name) equals: anotherShip name.
]

{ #category : 'tests' }
GameTest >> testWhenTheCurrentShipHasTwoPenalizationsThenTheTurnIsPassedToTheNextShipTwice [

	| ships aShip  aBoard oneDice dices aGame  anotherShip actualShipInGame |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	aGame penalize: aShip withTurns: 2.
	
	aGame executeTurn. 
	actualShipInGame:= aGame executeTurn. 

	self assert: (actualShipInGame name) equals: anotherShip name.
]

{ #category : 'tests' }
GameTest >> testWhenTheCurrentShipIsPenalizedAndItsTurnIsSkippedThenPenaltiesAreReduced [

	
	| ships aShip  aBoard oneDice dices aGame  anotherShip  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	aGame penalize: aShip withTurns: 2.
	
	aGame executeTurn. 

	self assert: (aGame penaltyFor: aShip) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenTheCurrentShipIsPenalizedThenTheTurnIsPassedToTheNextShip [

	| ships aShip  aBoard oneDice dices aGame  anotherShip actualShipInGame |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	aGame penalize: aShip withTurns: 2.
	
	actualShipInGame:= aGame executeTurn. 

	self assert: (actualShipInGame name) equals: anotherShip name.
]

{ #category : 'tests' }
GameTest >> testWhenTheFirstTurnIsExecutedThenTheFirstShipIsReturned [

	| ships aShip  actualShipTurn aBoard oneDice dices aGame  |
	
	aBoard := Board withATotalNumberOfCellsOf: 6 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

		
	actualShipTurn := aGame executeTurn.
	
	self assert: (actualShipTurn name) equals: aShip name.

]

{ #category : 'tests' }
GameTest >> testWhenTwoTurnsAreCorrectlyExecutedThenTheShipsAreMovedToTheirCorrectPosition [

	| ships aShip  aBoard oneDice dices aGame  anotherShip |
	
	aBoard := Board withATotalNumberOfCellsOf: 25 andAWormHoleBetweenCells: 2 and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Zorgons Ship'.
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn.
	aGame executeTurn.

	self assert: (aShip position) equals: 7.
	self assert: (anotherShip position) equals: 7.
]
