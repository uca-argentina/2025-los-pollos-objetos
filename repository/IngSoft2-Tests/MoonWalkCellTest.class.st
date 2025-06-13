Class {
	#name : 'MoonWalkCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
MoonWalkCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenAShipArrivesToAMoonWalkCellThenTheEffectIsApplied [

    | aGame aBoard aShip ships oneDice dices anotherShip numberOfCells cells |

	cells := OrderedCollection new.
	cells add: (NormalCell initializeCellOn: 1).
	cells add: (NormalCell initializeCellOn: 2).
	cells add: (NormalCell initializeCellOn: 3).
	cells add: (NormalCell initializeCellOn: 4).
	cells add: (MoonWalkCell initializeCellOn: 5 withRequiredValue: 2).
	cells add: (NormalCell initializeCellOn: 6).
	cells add: (NormalCell initializeCellOn: 7).
    numberOfCells := 7.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells whichAre:cells andAWormHoleBetweenCells: 6 and: 7.

    aShip := Ship named: 'Venture'.
	 anotherShip := Ship named: 'Sulaco'.
	 
    ships := OrderedCollection with: aShip.
	 ships add: anotherShip .

    oneDice := ChargedDice withATotalNumberOfFacesOf: 2.   
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	 aGame move: anotherShip to: 3 andConsume: 2.
	 aGame move: aShip to: 5 andConsume: 4.	
	 
	 self assert: (aGame positionOf: aShip ) equals: 5.
	 self assert: (aGame positionOf: anotherShip ) equals: 1.
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenAShipFallsIntoAMoonWalkCellAndTheSecondShipHasNoEnoughFuelToGoBackThenItStaysWhereItIs [

    | aGame aBoard aShip ships oneDice dices anotherShip numberOfCells someProbabilities aCellGenerator |

    numberOfCells := 20.
	 someProbabilities := Dictionary new
        at: 1 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 5) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 1 and: 2.

    aShip := Ship named: 'Venture'.
	 anotherShip := Ship named: 'Sulaco'.
	 
    ships := OrderedCollection with: aShip.
	 ships add: anotherShip .

    oneDice := ChargedDice withATotalNumberOfFacesOf: 5.   
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame move: aShip to: 5 andConsume: 4.
	 aGame move: anotherShip to: 6 andConsume: 5.
	 aGame move: aShip to: 9 andConsume: 4.
	
    self assert: (aShip position) equals: 9.   
	 self assert: (anotherShip position) equals: 6. 

]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenMoonWalkCellIsCreatedOnANegativeCellThenCreationFails [

	 self
        should: [MoonWalkCell initializeCellOn: -4 withRequiredValue: 1]
        raise: Error
        withMessageText: 'Required value must be a positive integer.'.
]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenMoonWalkCellIsCreatedWithNegativeRequiredValueThenCreationFails [

	 self
        should: [MoonWalkCell initializeCellOn: 4 withRequiredValue: -1]
        raise: Error
        withMessageText: 'Required value must be a positive integer.'.
]
