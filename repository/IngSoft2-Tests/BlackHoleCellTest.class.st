Class {
	#name : 'BlackHoleCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenABlackHoleCellIsInitializedWithANegativeNumberThenCreationFails [

	 self
        should: [BlackHoleCell initializeCellOn: -1]
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipArrivesToABlackHoleCellInTheFollowingLapThenItReturnsToThePreviusOne [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells someProbabilities aCellGenerator |

	 numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (BlackHoleCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 7.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 12.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 2
        with: aBoard
        and: dices
        and: ships.
	aShip position.

	aGame executeTurn .

    self assert: (aShip position) equals: 9.
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipArrivesToABlackHoleCellInTheThirdCellThenItGoesBackToTheInitialCell [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (BlackHoleCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 7.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 2.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 2
        with: aBoard
        and: dices
        and: ships.
	aShip position.

	aGame executeTurn .

    self assert: (aShip position) equals: 1.
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipArrivesToABlackHoleCellThenItGoesBackFourCells [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells someProbabilities aCellGenerator |

	 numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (BlackHoleCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 7.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 14.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn .

    self assert: (aShip position) equals: 11.
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipRunsOutOfFuelAfterArrivingToBlackHoleCellThenItStaysAtTheFirstCell [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (BlackHoleCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 10 and: 14.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn .

    self assert: (aShip position) equals: 1.
]
