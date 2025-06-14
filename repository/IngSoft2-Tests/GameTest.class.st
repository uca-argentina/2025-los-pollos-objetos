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
GameTest >> testWhenAGameIsInitializedWithAMaximumThrowOfTenThenTheSumOfDiceIsTen [

	| ships aShip  aBoard oneDice dices aGame  anotherShip numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 10. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	self assert: (aGame sumOfDiceSizes) equals: 10.
]

{ #category : 'tests' }
GameTest >> testWhenAGameIsInitializedWithAMaximumThrowOfTwentyAndTwoDieThenTheSumOfDiceIsTwenty [

	| ships aShip  aBoard oneDice dices aGame  anotherShip anotherDice numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 10.
	anotherDice := ChargedDice withATotalNumberOfFacesOf: 10. 
	dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	self assert: (aGame sumOfDiceSizes) equals: 20.
]

{ #category : 'tests' }
GameTest >> testWhenAShipIsPenalizeWithTwoMovesThenItsIncludedInThePenalizationsDictionary [

	| ships aShip  aBoard oneDice dices aGame  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame penalize: aShip withTurns: 2.

	self assert: (aGame penaltyFor: aShip) equals: 2.
]

{ #category : 'tests' }
GameTest >> testWhenAShipIsPenalizedThenTheFuelIsRestoredAfterLosingItsTurn [

	| ships aShip  aBoard oneDice dices aGame  anotherShip  fuelBeforePenalization fuelAfterPenalization theShipToTest numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 1 and: 2.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.
	aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
	
	aGame executeTurn. 
	aGame executeTurn.
	theShipToTest := aGame shipLike: aShip. 
	fuelBeforePenalization := theShipToTest currentFuel .
	aGame penalize: theShipToTest withTurns: 1. 
	aGame executeTurn. 	
	fuelAfterPenalization := theShipToTest currentFuel .
	
	self deny: fuelBeforePenalization equals: fuelAfterPenalization 
	
	
]

{ #category : 'tests' }
GameTest >> testWhenAShipIsPenalizedWithANonIntegerThenItFails [

	
	| ships aShip  aBoard oneDice dices aGame  anotherShip  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

	
	| ships aShip  aBoard oneDice dices aGame  anotherShip  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	
	self should:[aGame penalize: aShip withTurns: -2]
	raise: Error 
	withMessageText: 'The penalty must be a positive integer.'
	
	
]

{ #category : 'tests' }
GameTest >> testWhenAShipRunsOutOfFuelThenItStaysAtItsPlaceAndIsPenalized [

	| ships aShip  aBoard oneDice dices aGame  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 3. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn .
	aGame executeTurn .

	self assert: (aShip position) equals: 4.
	self assert: (aGame penaltyFor: aShip) equals: 2.
]

{ #category : 'tests' }
GameTest >> testWhenAShipRunsOutOfFuelThenItsPenalizedWithTwoTurns [

	| ships aShip  aBoard oneDice dices aGame  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn.
	aGame executeTurn.

	self assert: (aGame penaltyFor: aShip) equals: 2.
]

{ #category : 'tests' }
GameTest >> testWhenAShipWithTwoPenaltiesAreReduceByOneThenItHasOnePenaltyOnly [

	| ships aShip  aBoard oneDice dices aGame  anotherShip numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 1 and: 2.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
	
	aGame executeTurn. 
	aGame penalize: aShip withTurns: 2. 
	aGame reducePenaltyFor: aShip.
	
	self assert: (aGame penaltyFor: aShip) equals: 1 
	
	
]

{ #category : 'tests' }
GameTest >> testWhenAllShipsChargeOneUnitOfFuelAtTheSameTimeThenTheyAllHaveOneUnitOfFuel [

	| ships aShip  aBoard oneDice dices aGame  anotherShip numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Zathura'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 1. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame chargeFuelToShipsUpTo: 1.
	
	self assert: (aShip currentFuel) equals: 1.
	self assert: (anotherShip currentFuel) equals: 1.


]

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedThenItHasAWinningLap [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices numberOfCells someProbabilities aCellGenerator |

    "aGame := Game new."

    numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := SpaceShipGame
                 completedAtLap: 1
                 with: aBoard
                 and: dices
                 and: ships.

    self assert: aGame winningLap equals: 1
]

{ #category : 'tests' }
GameTest >> testWhenGameIsCreatedWithAllThePiecesThenIsSuccesfullyCreated [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: aGame winningLap equals: 1
]

{ #category : 'tests' }
GameTest >> testWhenGameIsStartedThenAllShipsAreAtTheFirstCell [

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices firstCell numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := SpaceShipGame
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

    | aGame aBoard aShip anotherShip ships oneDice anotherDice dices numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.

    aShip := Ship named: 'Executor'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 6.
    anotherDice := Dice withATotalNumberOfFacesOf: 4.
    dices := OrderedCollection with: oneDice with: anotherDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: (aGame start) equals: 'The Game Has Started'
]

{ #category : 'tests' }
GameTest >> testWhenOneGameIsInitializedWithAMaximumThrowOfFiveThenAllShipsHaveTenUnitsOfFuel [

    | aGame aBoard aShip  ships oneDice  dices anotherShip numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
	 anotherShip := Ship named: 'The Batwing'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := Dice withATotalNumberOfFacesOf: 5. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: aShip currentFuel equals: 10.
	 self assert: anotherShip currentFuel equals: 10.
]

{ #category : 'tests' }
GameTest >> testWhenOneGameIsInitializedWithAMaximumThrowOfFiveThenShipsHaveTenUnitsOfFuel [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 5. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    self assert: aShip currentFuel equals: 10.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipGetsToTheWinningLapThenTheGameFinishes [

	| aGame aBoard aShip  ships oneDice  dices newPosition numberOfCells someProbabilities aCellGenerator |
	 numberOfCells := 6.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Apolo'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 7. 
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
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

	| aGame aBoard aShip  ships oneDice  dices newPosition numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 7. 
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
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

	| aGame aBoard aShip  ships oneDice  dices   blackHolesSecondEntrance shipPositionAfterTheDices positionAfterDeterminingIfItFallsIntoABlackHole numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 25.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 8.
	aShip := Ship named: 'Serenity'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 4. 
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
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

	| aGame aBoard aShip  ships oneDice  dices  blackHolesFirstEntrance shipPositionAfterTheDices positionAfterDeterminingIfItFallsIntoABlackHole  numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 25.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 20.
	aShip := Ship named: 'Elysium'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 19. 
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
		completedAtLap: 1
		with: aBoard
		and: dices
		and: ships.
			
	"aShip throw: dices."
	aGame throwDiceFor: aShip.
	
	shipPositionAfterTheDices := aGame positionOf: aShip. 
	aGame determineTheConsequencesOfTheThrowIn: shipPositionAfterTheDices forShip: aShip.
	
	positionAfterDeterminingIfItFallsIntoABlackHole := aGame positionOf: aShip.	
	
	blackHolesFirstEntrance := aBoard wormsHolesFirstEntrance.
	
	self assert: positionAfterDeterminingIfItFallsIntoABlackHole equals: blackHolesFirstEntrance.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipHasTwoUnitsOfFuelAndMakesOneMoveThenItConsumesOneUnitOfFuel [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 1. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame throwDiceFor: aShip.

    self assert: aShip currentFuel equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMakesOneLapThenItReturnsToTheFirstCell [

    | aGame aBoard aShip  ships oneDice  dices  anotherShip shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.
    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 10.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame throwDiceFor: aShip.
	shipPositionAfterTheDices := aShip position.

    self assert: (aShip position) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMakesOneLapThenTheAmountOfLapsIsUpdated [

    | aGame aBoard aShip  ships oneDice  dices  anotherShip shipsNumberOfLapsAfterThrowing numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.
    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 10.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame updateLapFor: aShip withTotalSteps: 10.
	shipsNumberOfLapsAfterThrowing := aShip currentLap.

    self assert: (shipsNumberOfLapsAfterThrowing) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMakesOneMoveThenItIsForwardedToTheNewPosition [

    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

    | aGame aBoard aShip  ships oneDice  dices secondCell numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame move: aShip to: 2 andConsume: 1.
	 secondCell := aBoard cellNumber: (aShip position).

    self assert: (secondCell includes: aShip) equals: true.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipMovesOnePositionForwardThenItIsNoLongerInThePreviousCell [

    | aGame aBoard aShip  ships oneDice  dices firstCell numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame move: aShip to: 3 andConsume: 1.
	 firstCell := aBoard cellNumber: (aShip lastPosition).

    self deny: (firstCell includes: aShip) equals: true.
]

{ #category : 'tests' }
GameTest >> testWhenOneShipThrowsDiceAndReturnsOneThenItIsForwardedOnePosition [

    | aGame aBoard aShip  ships oneDice  dices  intialShipPosition numberOfCells someProbabilities aCellGenerator |
    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 16 and: 19.

    aShip := Ship named: 'Serenity'.
    ships := OrderedCollection with: aShip.

    oneDice := Dice withATotalNumberOfFacesOf: 15. 
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

    | aGame aBoard aShip  ships oneDice  dices  anotherShip shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 16 and: 19.
    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Axiom'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 19.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

	| ships aShip  aBoard oneDice dices aGame  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame skipTurnFor: aShip.

	self assert: (aGame penaltyFor: aShip) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenTheCurrentShipHasTwoPenalizationsThenItLosesTwoTurns [

	| ships aShip  aBoard oneDice dices aGame  anotherShip actualShipInGame numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

	| ships aShip  aBoard oneDice dices aGame  anotherShip actualShipInGame numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

	
	| ships aShip  aBoard oneDice dices aGame  anotherShip  numberOfCells someProbabilities aCellGenerator shipToTest |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection new.
	ships add: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

	| ships aShip  aBoard oneDice dices aGame  anotherShip actualShipInGame numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
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

	| ships aShip  actualShipTurn aBoard oneDice dices aGame  numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	actualShipTurn := aGame executeTurn.
	
	self assert: (actualShipTurn name) equals: aShip name.

]

{ #category : 'tests' }
GameTest >> testWhenTheShipIsToldToMoveBakToLastPositionThenItMovesBack [

	| ships aShip  aBoard oneDice dices aGame  anotherShip numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
	
	aGame executeTurn. 
	aGame moveShipToLastPlay: aShip. 

	self assert: (aShip position) equals: 1.
]

{ #category : 'tests' }
GameTest >> testWhenTryingToIdentifyASpecificShipOfTheGameThenTheProperShipIsReturned [

	| ships aShip  aBoard oneDice dices aGame  anotherShip numberOfCells someProbabilities aCellGenerator gamesShip |
	
	numberOfCells := 6.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 5.
	aShip := Ship named: 'Zathura'.
	anotherShip := Ship named: 'Adventure'.
	
	ships := OrderedCollection with: aShip.
	ships add: anotherShip .

	oneDice := ChargedDice withATotalNumberOfFacesOf: 1. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	gamesShip := aGame shipLike: aShip. 
	
	self assert: (gamesShip name) equals: 'Zathura'.


]

{ #category : 'tests' }
GameTest >> testWhenTwoTurnsAreCorrectlyExecutedThenTheShipsAreMovedToTheirCorrectPosition [

	| ships aShip  aBoard oneDice dices aGame  anotherShip numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 25.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Zorgons Ship'.
	ships := OrderedCollection with: aShip.
	ships add: anotherShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 6. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn.
	aGame executeTurn.

	self assert: (aShip position) equals: 7.
	self assert: (anotherShip position) equals: 7.
]
