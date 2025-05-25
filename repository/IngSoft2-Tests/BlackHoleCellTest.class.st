Class {
	#name : 'BlackHoleCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleCellTest >> testWhenAShipArrivesToABlackHoleCellThenItGoesBackFourCells [

    | aGame aBoard aShip  ships oneDice  dices aBlackHoleCell |

    aBoard := Board withATotalNumberOfCellsOf: 20 andAWormHoleBetweenCells: 10 and: 14.
	aBlackHoleCell := BlackHoleCell initializeCellOn: 5.
	aBoard changeCellAt: 5 to: aBlackHoleCell. 

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 4.  
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame throwDiceFor: aShip.

    self assert: (aShip position) equals: 1.
]
