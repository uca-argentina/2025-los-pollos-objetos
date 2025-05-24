Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
BoardTest >> testWhenAShipEntersACellOfTheBoardThenItIsInThere [

	| aBoard aShip firstCell |
	aBoard := Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Executor'.
	
	aBoard addShip: aShip toCellAt: 0.
	firstCell := aBoard cellNumber: 0.
	
	self assert: (firstCell includes: aShip) equals: true.
]

{ #category : 'tests' }
BoardTest >> testWhenAShipLeavesACellOfTheBoardThenItIsNoLongerInThere [

	| aBoard aShip firstCell |
	aBoard := Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Venture'.
	
	aBoard addShip: aShip toCellAt: 0.
	firstCell := aBoard cellNumber: 0.
	aBoard removeShip: aShip fromCellAt: 0.
	
	self deny: (firstCell includes: aShip) equals: true.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceAndSecondEntranceAreEqualThenCreationFails [

	self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 1  and: 1.]
        raise: Error
        withMessageText: 'The entrances of the Black Hole must be in different cells.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceIsANegativeCellThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: -2  and: 6.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceIsNonIntegerThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 'dos'  and: 6.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceIsOutOfBoardsRangeThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 11  and: 2.]
        raise: Error
        withMessageText: 'The cells of the Black Hole must in the board.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceCellIsSmallerThanBlackHolesFirstEntranceCellThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 6  and: 1.]
        raise: Error
        withMessageText: 'The First Entrance of Black Hole must come before the Second Entrance.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceIsANegativeCellThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2  and: -6.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceIsNonIntegerThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2  and: 'seis'.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntrnaceIsOutOfBoardsRangeThenCreationFails [

    self
        should: [Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'The cells of the Black Hole must in the board.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithInvalidNumberOfCellsThenItFails [

    self
        should: [Board  withATotalNumberOfCellsOf: -1 andABlackHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithNonIntegerThenItFails [

    self
        should: [Board  withATotalNumberOfCellsOf: 'uno' andABlackHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithZeroCellsThenItFails [

    self
        should: [Board  withATotalNumberOfCellsOf: 0 andABlackHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithOneCellThenHasCell [

    | aBoard |
    "aBoard := Board new."

    "aBoard := Board withATotalNumberOfCellsOf: 1."

    aBoard := Board withATotalNumberOfCellsOf: 2 andABlackHoleBetweenCells: 1 and: 2.


    self assert: (aBoard numberOfCells) equals: 2.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsSetWithABlackHoleThenItHasAFirstEntrance [

    | aBoard |

    aBoard := Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2  and: 6.

    self assert: (aBoard blackHolesFirstEntrance) equals: 2.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsSetWithABlackHoleThenItHasASecondEntrance [

    | aBoard |

    aBoard := Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2  and: 6.

    self assert: (aBoard blackHolesSecondEntrance ) equals: 6.
]

{ #category : 'tests' }
BoardTest >> testWhenMultipleShipsEnterACellOfTheBoardThenTheyAreInThere [

	| aBoard aShip firstCell anotherShip ships |
	aBoard := Board withATotalNumberOfCellsOf: 10 andABlackHoleBetweenCells: 2 and: 5.
	aShip := Ship named: 'Executor'.
	anotherShip := Ship named: 'Axiom'.
	ships := OrderedCollection with: aShip with: anotherShip.
	
	aBoard getShipsIntoFirstCellOfTheBoard: ships.
	firstCell := aBoard cellNumber: 0.
	
	self assert: (firstCell includes: aShip) equals: true.
	self assert: (firstCell includes: anotherShip) equals: true.
]
