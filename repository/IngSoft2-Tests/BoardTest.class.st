Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> should: arg1 raise: arg2 withMessageText: arg3 [

	self
		should: arg1
		raise: arg2
		withExceptionDo: [ :arg4 |
		self assert: arg4 messageText equals: arg3 ]
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithInvalidNumberOfCellsThenItFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

    self
        should: [Board  withATotalNumberOfCellsOf: -1 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithNonIntegerThenItFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

    self
        should: [Board  withATotalNumberOfCellsOf: 'uno' generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithZeroCellsThenItFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

    self
        should: [Board  withATotalNumberOfCellsOf: 0 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithOneCellThenHasCell [

    | aBoard numberOfCells someProbabilities aCellGenerator |
    "aBoard := Board new."

    "aBoard := Board withATotalNumberOfCellsOf: 1."
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

   "aBoard := Board withATotalNumberOfCellsOf: 2 andAWormHoleBetweenCells: 1 and: 2."
	aBoard := Board withATotalNumberOfCellsOf: 2 generatedWith: aCellGenerator andAWormHoleBetweenCells: 1 and: 2.
	
	self assert: (aBoard numberOfCells) equals: 2.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsSetWithAWormsHoleThenItHasAFirstEntrance [

    | aBoard numberOfCells someProbabilities aCellGenerator |
	 numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    "aBoard := Board withATotalNumberOfCellsOf: 10 andAWormHoleBetweenCells: 2  and: 6."
	 aBoard := Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 6.
	
    self assert: (aBoard wormsHolesFirstEntrance) equals: 2.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsSetWithAWormsHoleThenItHasASecondEntrance [

    | aBoard numberOfCells someProbabilities aCellGenerator |
	 numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    "aBoard := Board withATotalNumberOfCellsOf: 10 andAWormHoleBetweenCells: 2  and: 6."
	 aBoard := Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 6.

    self assert: (aBoard wormsHolesSecondEntrance ) equals: 6.
]

{ #category : 'tests' }
BoardTest >> testWhenMultipleShipsEnterACellOfTheBoardThenTheyAreInThere [

	| aBoard aShip firstCell anotherShip ships numberOfCells someProbabilities aCellGenerator aDice dices |
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 0.4
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     at: 0.6
		                     put:
			                     (BlackHoleCell initializeCellOn: numberOfCells);
		                     at: 0.8
		                     put:
			                     (HyperGravityCell
				                      initializeCellOn: numberOfCells
				                      withRequiredValue: 4);
		                     at: 0.9
		                     put:
			                     (MoonWalkCell
				                      initializeCellOn: numberOfCells
				                      withRequiredValue: 4);
		                     at: 0.98 put: (HyperJumpCell
				                      initializeCellOn: numberOfCells
				                      withParsecValues: #( 25 10 5 )
				                      boardLength: 100
				                      numberOfCells: 100);
		                     at: 1
		                     put:
			                     (AtomicBombCell initializeCellOn:
					                      numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: 10
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 2
		          and: 5.
	aDice := AChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: aDice.
	aShip := Ship named: 'Executor' withAChargeBasedOn: dices.
	anotherShip := Ship named: 'Axiom' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip with: anotherShip.

	aBoard getShipsIntoFirstCellOfTheBoard: ships.
	firstCell := aBoard cellNumber: 1.

	self assert: (firstCell includes: aShip) equals: true.
	self assert: (firstCell includes: anotherShip) equals: true
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesFirstEntranceAndSecondEntranceAreEqualThenCreationFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 1  and: 1.]
        raise: Error
        withMessageText: 'The entrances of the Black Hole must be in different cells.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesFirstEntranceIsANegativeCellThenCreationFails [
	
	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: -2  and: 6.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesFirstEntranceIsNonIntegerThenCreationFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 'dos'  and: 6.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesFirstEntranceIsOutOfBoardsRangeThenCreationFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 11  and: 2.]
        raise: Error
        withMessageText: 'The cells of the Black Hole must in the board.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesSecondEntranceCellIsSmallerThanWormsHolesFirstEntranceCellThenCreationFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 6  and: 1.]
        raise: Error
        withMessageText: 'The First Entrance of Black Hole must come before the Second Entrance.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesSecondEntranceIsANegativeCellThenCreationFails [

	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: -6.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesSecondEntranceIsNonIntegerThenCreationFails [
	
	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2  and: 'seis'.]
        raise: Error
        withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenWormsHolesSecondEntrnaceIsOutOfBoardsRangeThenCreationFails [
	
	| numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 10.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
    self
        should: [Board withATotalNumberOfCellsOf: 10 generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 11.]
        raise: Error
        withMessageText: 'The cells of the Black Hole must in the board.'.
]
