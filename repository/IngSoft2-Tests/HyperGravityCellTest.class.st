Class {
	#name : 'HyperGravityCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenAnHyperGravityCellIsInitializedWithANegativeNumberThenCreationFails [

	 self
        should: [HyperGravityCell initializeCellOn: -2 withRequiredValue: 3.]
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenHyperGravityCellIsCreatedWithNegativeRequiredValueThenItFails [

	 self
        should: [HyperGravityCell initializeCellOn: 4 withRequiredValue: -1]
        raise: Error
        withMessageText: 'Required value must be a positive integer.'.
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenShipArrivesToHyperGravityCellWithEnoughRollThenItRemainsOnTheCell [

    | aGame aBoard aShip ships oneDice dices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 15 and: 17.
	
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

    self assert: (aShip position) equals: 5.
]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenShipArrivesToHyperGravityCellWithExactRollThenItStaysOnHyperGravityCell [

    | aGame aBoard aShip ships oneDice dices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 15 and: 17.

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

    self assert: (aShip position) equals: 5.   

]

{ #category : 'tests' }
HyperGravityCellTest >> testWhenShipArrivesToHyperGravityCellWithNotEnoughRollThenItDoesntMoveForward [

    | aGame aBoard aShip ships oneDice dices numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 6) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 15 and: 17.

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
