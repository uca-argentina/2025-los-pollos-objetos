Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesFromAPositionThenItKnowsItsLastPosition [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	numberOfCells := 20.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 17
		          and: 20.
	ships := OrderedCollection with: aShip.
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aShip moveFrom: 1 andConsume: 2.

	self assert: aShip lastPosition equals: 1
]

{ #category : 'tests' }
ShipTest >> testWhenAShipWithAChargeOfFourFuelsMovesFromAPositionConsumingTwoFuelsAThenFuelConsumptionIsProperlyDone [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Sulaco' withAChargeBasedOn: dices.
	numberOfCells := 20.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 17
		          and: 20.
	ships := OrderedCollection with: aShip.
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aShip moveFrom: 3 andConsume: 2.

	self assert: aShip currentFuel equals: 2
]

{ #category : 'tests' }
ShipTest >> testWhenNewShipIsCreatedThenItHasAName [

	| aShip oneDice dices |
	"aShip := Ship new."
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Millenium Falcon' withAChargeBasedOn: dices.

	self assert: aShip name equals: 'Millenium Falcon'
]

{ #category : 'tests' }
ShipTest >> testWhenNewShipIsInstancedWithANameThenItHasAName [

	| aShip oneDice dices |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'The Batwing' withAChargeBasedOn: dices.

	self assert: aShip name equals: 'The Batwing'
]

{ #category : 'tests' }
ShipTest >> testWhenShipConsumesANegativeAmountOfFuelThenItFails [

	| aShip oneDice dices |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Elysium' withAChargeBasedOn: dices.

	self
		should: [ aShip consumeFuel: -1 ]
		raise: Error
		withMessageText:
		'Charge and consumption of fuel must be a positive amount.'
]

{ #category : 'tests' }
ShipTest >> testWhenShipConsumesANonValidAmountOfFuelThenItFails [

	| aShip oneDice dices |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Elysium' withAChargeBasedOn: dices.

	self
		should: [ aShip consumeFuel: 'dos' ]
		raise: Error
		withMessageText:
		'Charge and consumption of fuel must be a positive amount.'
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasTenUnitsOfFuelAndConsumesOneThenItHasNineUnitsOfFuel [

	| aShip oneDice dices |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Serenity' withAChargeBasedOn: dices.
	aShip consumeFuel: 1.

	self assert: aShip currentFuel equals: 9
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasTwoUnitsOfFuelAndConsumesThreeUnitsThenCurrentChargeRemainsTheSame [

	| aShip oneDice dices |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 1.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Axiom' withAChargeBasedOn: dices.

	self
		should: [ aShip consumeFuel: 3 ]
		raise: Error
		withMessageText: 'Ship has no enough fuel for this consumption'.

	self assert: aShip currentFuel equals: 2
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsCreatedThenItStarsAtStartingPosition [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Discovery One' withAChargeBasedOn: dices.
	numberOfCells := 20.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 17
		          and: 20.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	"self assert: (aShip position) equals: 1."
	self assert: (aGame positionOf: aShip) equals: 1
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsCreatedWithNoNameThenCreationFails [

	| oneDice dices |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	self
		should: [ Ship named: '' withAChargeBasedOn: dices ]
		raise: Error
		withMessageText: 'Ship must be initialized with a name.'
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsInitializedThenItHasAChargeOfFuelTwoTimesTheMaximumThrowOfDie [

	| aShip oneDice dices twoTimesMaximumThrow |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	twoTimesMaximumThrow := (dices
		                     inject: 0
		                     into: [ :sum :aDie | sum + aDie sizeOfTheDice ]) * 2.
	aShip := Ship named: 'Discovery One' withAChargeBasedOn: dices.

	self assert: aShip currentFuel equals: twoTimesMaximumThrow.
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsInitializedThenItHasNotCompletedAnyLaps [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Venture' withAChargeBasedOn: dices.
	numberOfCells := 10.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 2
		          and: 6.
	ships := OrderedCollection with: aShip.
	oneDice := ChargedDice withATotalNumberOfFacesOf: 10.
	dices := OrderedCollection with: oneDice.
	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	self assert: (aGame currentLapFor: aShip) equals: 0.
]

{ #category : 'tests' }
ShipTest >> testWhenShipMovesOnePositionFromStartingPositionThenItMovesAccordingly [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Discovery One' withAChargeBasedOn: dices.
	"aShip chargeFuelUpTo: 5.
	
	aShip moveTo: 1 andConsume: 1."
	numberOfCells := 20.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 17
		          and: 20.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame move: aShip to: 1 andConsume: 1.

	"self assert: (aShip position) equals: 1."
	self assert: (aGame positionOf: aShip) equals: 1
]

{ #category : 'tests' }
ShipTest >> testWhenShipRunsOutOfFuelAndRestoresItThenItFillsUpTheTank [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame initialFuel |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Apolo' withAChargeBasedOn: dices.

	"aShip chargeFuelUpTo: 5.
	aShip moveTo: 5 andConsume: 5."
	numberOfCells := 20.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 17
		          and: 20.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	initialFuel := aShip currentFuel.
	aGame move: aShip to: 5 andConsume: 5.
	aShip restoreFuel.

	self assert: aShip currentFuel equals: initialFuel
]

{ #category : 'tests' }
ShipTest >> testWhenShipRunsOutOfFuelThenItStaysAtCurrentPosition [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5.
	dices := OrderedCollection with: oneDice.
	aShip := Ship named: 'Axiom' withAChargeBasedOn: dices.
	"aShip chargeFuelUpTo: 1.
	aShip moveTo: 1 andConsume: 1."

	numberOfCells := 20.
	someProbabilities := Dictionary new
		                     at: 1
		                     put:
			                     (NormalCell initializeCellOn: numberOfCells);
		                     yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.

	aBoard := Board
		          withATotalNumberOfCellsOf: numberOfCells
		          generatedWith: aCellGenerator
		          andAWormHoleBetweenCells: 17
		          and: 20.
	ships := OrderedCollection with: aShip.

	aGame := SpaceShipGame
		         completedAtLap: 1
		         with: aBoard
		         and: dices
		         and: ships.

	aGame move: aShip to: 1 andConsume: 1.

	self assert: (aGame positionOf: aShip) equals: aShip lastPosition
]
