Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
MoonWalkTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
MoonWalkTest >> testWhenMoonWalkCellIsCreatedWithNegativeRequiredCellOn [

	 self
        should: [MoonWalk initializeCellOn: -4 withRequiredValue: 1]
        raise: Error
        withMessageText: 'Required value must be a positive integer.'.
]

{ #category : 'tests' }
MoonWalkTest >> testWhenMoonWalkCellIsCreatedWithNegativeRequiredValueThenItFails [

	 self
        should: [MoonWalk initializeCellOn: 4 withRequiredValue: -1]
        raise: Error
        withMessageText: 'Required value must be a positive integer.'.
]

{ #category : 'tests' }
MoonWalkTest >> testWhenaShipArrivesToMoonWalkCellAndTheOtherShipHaveNotEnoughFuelToRetrocesThenAtherShipGoesBackToOne [

    | aGame aBoard aShip ships oneDice dices aMoonWalkCell anotherShip |

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 1 and: 2.

    aMoonWalkCell := MoonWalk initializeCellOn: 9 withRequiredValue: 2.
    aBoard changeCellAt: 9 to: aMoonWalkCell.

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
	
	 aGame executeTurn . 
	 aGame executeTurn . 

    self assert: (aShip position) equals: 9.   
	 self assert: (anotherShip position) equals: 1. 

]

{ #category : 'tests' }
MoonWalkTest >> testWhenaShipArrivesToMoonWalkCellThenTheEffectIsApply [

    | aGame aBoard aShip ships oneDice dices aMoonWalkCell anotherShip |

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 1 and: 2.

    aMoonWalkCell := MoonWalk initializeCellOn: 9 withRequiredValue: 2.
    aBoard changeCellAt: 9 to: aMoonWalkCell.

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
	
	 aGame executeTurn . 
	 aGame executeTurn . 

    self assert: (aShip position) equals: 9.   
	 self assert: (anotherShip position) equals: 1. 

]
