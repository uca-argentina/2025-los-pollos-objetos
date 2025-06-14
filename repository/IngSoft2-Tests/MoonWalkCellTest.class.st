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
	 
    ships := OrderedCollection new.
	 ships add: aShip.
	 ships add: anotherShip .

    oneDice := ChargedDice withATotalNumberOfFacesOf: 2.   
    dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	 aGame executeTurn.
	 aGame executeTurn.
	 aGame skipTurnFor: aShip.
	 aGame skipTurnFor: aShip.
	 aGame executeTurn.
	 aGame executeTurn.
	 aGame executeTurn.
	 
	 self assert: (aGame positionOf: aShip ) equals: 5.
	 self assert: (aGame positionOf: anotherShip ) equals: 1.
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
