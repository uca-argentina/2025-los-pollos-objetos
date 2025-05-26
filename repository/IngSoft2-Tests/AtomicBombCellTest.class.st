Class {
	#name : 'AtomicBombCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
AtomicBombCellTest >> testWhenAAtomicBombCellIsInitializedWithANegativeNumberThenCreationFails [

	 self
        should: [AtomicBombCell initializeCellOn: -1]
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
AtomicBombCellTest >> testWhenAShipsArrivesToAtomicBombCellThenAllReturnToFirstCell [

	| aGame aBoard aShip anotherShip ships oneDice dices atomicBombCell |
	aBoard := Board
		          withATotalNumberOfCellsOf: 20
		          andAWormHoleBetweenCells: 15
		          and: 17.
	atomicBombCell := AtomicBombCell initializeCellOn: 5.
	aBoard changeCellAt: 5 to: atomicBombCell.

	aShip := Ship named: 'Venture'.
	anotherShip := Ship named: 'Millenium Falcon'.
	ships := OrderedCollection with: aShip with: anotherShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.

	aGame := Game
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame move: aShip to: 2 andConsume: 1.
	aGame executeTurn.
	aGame executeTurn.

	self assert: anotherShip position equals: 1.
	self assert: aShip position equals: 1
]

{ #category : 'tests' }
AtomicBombCellTest >> testWhenMultipleShipsArriveToAtomicBombCellThenAllReturnToFirstCell [

    | aGame aBoard aShip anotherShip ships oneDice dices atomicBombCell |

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 15 and: 17.
    atomicBombCell := AtomicBombCell initializeCellOn: 5.
    aBoard changeCellAt: 5 to: atomicBombCell.

    aShip := Ship named: 'Venture'.
    anotherShip := Ship named: 'Millenium Falcon'.
    ships := OrderedCollection with: aShip with: anotherShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.   
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame executeTurn.
	aGame executeTurn. 

    self assert: (aShip position) equals: 1.
    self assert: (anotherShip position) equals: 1.

]

{ #category : 'tests' }
AtomicBombCellTest >> testWhenShipArrivesToAtomicBombCellThenItReturnsToFirstCell [

    | aGame aBoard aShip ships oneDice dices atomicBombCell |

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 15 and: 17.
    atomicBombCell := AtomicBombCell initializeCellOn: 5.
    aBoard changeCellAt: 5 to: atomicBombCell.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.   
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame executeTurn . 

    self assert: (aShip position) equals: 1.

]

{ #category : 'tests' }
AtomicBombCellTest >> testWhenShipArrivesToAtomicBombCellThenItReturnsToFirstCellAndRestoreFuel [

    | aGame aBoard aShip ships oneDice dices atomicBombCell |

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 15 and: 17.
    atomicBombCell := AtomicBombCell initializeCellOn: 5.
    aBoard changeCellAt: 5 to: atomicBombCell.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.   
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame executeTurn . 

    self assert: (aShip currentFuel) equals: 8.

]
