Class {
	#name : 'WormHoleCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormHoleCellTest >> testWhenOneShipGetsToTheWormsHolesFirstEntranceThenItIsForwardedToTheSecondEntranceOfTheWormsHole [

	| aGame aBoard aShip  ships oneDice  dices   blackHolesSecondEntrance shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator |
	
	numberOfCells := 25.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 8.
	aShip := Ship named: 'Serenity'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 4. 
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
		completedAtLap: 1
		with: aBoard
		and: dices
		and: ships.
		
	aGame executeTurn.
	
	shipPositionAfterTheDices := aGame positionOf: aShip. 
	blackHolesSecondEntrance := aBoard wormsHolesSecondEntrance.
	
	self assert: shipPositionAfterTheDices equals: blackHolesSecondEntrance.
]

{ #category : 'tests' }
WormHoleCellTest >> testWhenOneShipGetsToTheWormsHolesSecondEntranceThenItIsForwardedToTheFirstEntranceOfTheWormHole [

	| aGame aBoard aShip  ships oneDice  dices  blackHolesFirstEntrance shipPositionAfterTheDices  numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 25.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 5 and: 20.
	aShip := Ship named: 'Elysium'.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 19. 
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
		completedAtLap: 1
		with: aBoard
		and: dices
		and: ships.
			
	aGame executeTurn.
	
	shipPositionAfterTheDices := aGame positionOf: aShip. 	
	blackHolesFirstEntrance := aBoard wormsHolesFirstEntrance.
	
	self assert: shipPositionAfterTheDices equals: blackHolesFirstEntrance.
]
