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

    | aGame aBoard aShip ships oneDice dices aMoonWalkCell anotherShip |

    aMoonWalkCell := MoonWalkCell initializeCellOn: 9 withRequiredValue: 2.

    aBoard := ChargedBoardWithOneMoonWalkCell withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 1 and: 2 andAMoonWalkCell: aMoonWalkCell onCell: 9.

    aShip := Ship named: 'Venture'.
	 anotherShip := Ship named: 'Sulaco'.
	 
    ships := OrderedCollection with: aShip.
	 ships add: anotherShip .

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.   
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    aGame executeTurn .
	 aGame executeTurn .
	
	 aGame skipTurnFor: aShip.
	 aGame skipTurnFor: anotherShip .
	 
	 aGame executeTurn . 

    self assert: (aShip position) equals: 9.   
	 self assert: (anotherShip position) equals: 3. 

]

{ #category : 'tests' }
MoonWalkCellTest >> testWhenAShipFallsIntoAMoonWalkCellAndTheSecondShipHasNoEnoughFuelToGoBackThenItStaysWhereItIs [

    | aGame aBoard aShip ships oneDice dices aMoonWalkCell anotherShip |

    aMoonWalkCell := MoonWalkCell initializeCellOn: 9 withRequiredValue: 5.

    aBoard := ChargedBoardWithOneMoonWalkCell withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 1 and: 2 andAMoonWalkCell: aMoonWalkCell onCell: 9.

    aShip := Ship named: 'Venture'.
	 anotherShip := Ship named: 'Sulaco'.
	 
    ships := OrderedCollection with: aShip.
	 ships add: anotherShip .

    oneDice := ChargedDice withATotalNumberOfFacesOf: 5.   
    dices := OrderedCollection with: oneDice.

    aGame := Game
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
