Class {
	#name : 'WormHoleCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormHoleCellTest >> testWhenOneShipGetsToTheWormsHolesFirstEntranceThenItIsForwardedToTheSecondEntranceOfTheWormsHole [

	| aGame aBoard aShip ships oneDice dices blackHolesSecondEntrance shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 25.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 5
		          and: 8.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 4.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Serenity' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	shipPositionAfterTheDices := aGame positionOf: aShip.
	blackHolesSecondEntrance := aBoard wormsHolesSecondEntrance.

	self
		assert: shipPositionAfterTheDices
		equals: blackHolesSecondEntrance
]

{ #category : 'tests' }
WormHoleCellTest >> testWhenOneShipGetsToTheWormsHolesSecondEntranceThenItIsForwardedToTheFirstEntranceOfTheWormHole [

	| aGame aBoard aShip ships oneDice dices blackHolesFirstEntrance shipPositionAfterTheDices numberOfCells someProbabilities aCellGenerator |
	numberOfCells := 25.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 5
		          and: 20.
	oneDice := AChargedDice withATotalNumberOfFacesOf: 19.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Elysium' withAChargeBasedOn: dices.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame executeTurn.

	shipPositionAfterTheDices := aGame positionOf: aShip.
	blackHolesFirstEntrance := aBoard wormsHolesFirstEntrance.

	self
		assert: shipPositionAfterTheDices
		equals: blackHolesFirstEntrance
]
