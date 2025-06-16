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
BlackHoleCellTest >> testWhenAShipArrivesToABlackHoleCellThenItGoesBackFourCells [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells cells |

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (BlackHoleCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
    numberOfCells := 7.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells whichAre: cells andAWormHoleBetweenCells: 6 and: 7.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.  
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 2
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn .

    self assert: ((aGame positionOf: aShip) - (aShip lastPosition)) equals: -4.
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipRunsOutOfFuelAfterArrivingToBlackHoleCellThenItHasAPenaltyForTwoTurns [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells cells |

   cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (BlackHoleCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
   numberOfCells := 7.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells whichAre: cells andAWormHoleBetweenCells: 6 and: 7.
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

    self assert: (aGame penaltyFor: aShip) equals: 2.
]

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipRunsOutOfFuelAfterArrivingToBlackHoleCellThenItStaysAtThePreviousCell [

    | aGame aBoard aShip  ships oneDice  dices numberOfCells cells |

   cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (BlackHoleCell initializeCellOn: 5).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
   numberOfCells := 7.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells whichAre: cells andAWormHoleBetweenCells: 6 and: 7.
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

    self assert: (aGame positionOf: aShip) equals: 1.
]
