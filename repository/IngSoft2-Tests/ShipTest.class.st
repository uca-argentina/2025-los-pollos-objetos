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
	aShip := Ship named: 'Sulaco'.
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 20.
	ships := OrderedCollection with: aShip.
	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.
    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aShip moveFrom: 1 andConsume: 2.
	
	self assert: (aShip lastPosition) equals: 1.
]

{ #category : 'tests' }
ShipTest >> testWhenAShipWithAChargeOfFourFuelsMovesFromAPositionConsumingTwoFuelsAThenFuelConsumptionIsProperlyDone [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	aShip := Ship named: 'Sulaco'.
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 20.
	ships := OrderedCollection with: aShip.
	oneDice := ChargedDice withATotalNumberOfFacesOf: 2. 
	dices := OrderedCollection with: oneDice.
    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aShip moveFrom: 3 andConsume: 2.
	
	self assert: (aShip currentFuel) equals: 2.
]

{ #category : 'tests' }
ShipTest >> testWhenNewShipIsCreatedThenItHasAName [

	| aShip |
	
	"aShip := Ship new."
	aShip := Ship named: 'Millenium Falcon'.
	
	self assert: (aShip name) equals: 'Millenium Falcon'
]

{ #category : 'tests' }
ShipTest >> testWhenNewShipIsInstancedWithANameThenItHasAName [

	| aShip |
	
	aShip := Ship named: 'The Batwing'.
	
	self assert: (aShip name) equals: 'The Batwing'
]

{ #category : 'tests' }
ShipTest >> testWhenShipConsumesANegativeAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Elysium'.
	aShip chargeFuelUpTo: 10.
	
	self
		should: [aShip consumeFuel: -1]
		raise: Error
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipConsumesANonValidAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Elysium'.
	aShip chargeFuelUpTo: 10.
	
	self
		should: [aShip consumeFuel: 'dos']
		raise: Error
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasOneUnitOfFuelAndConsumesTwoUnitsThenCurrentChargeRemainsTheSame [

	| aShip |
	aShip := Ship named: 'Axiom'.
	aShip chargeFuelUpTo: 1.
	
	self
		should: [aShip consumeFuel: 2]
		raise: Error
		withMessageText: 'Ship has no enough fuel for this consumption'.
		
	self assert: (aShip currentFuel ) equals: 1.
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasOneUnitOfFuelAndConsumesTwoUnitsThenItFails [

	| aShip |
	aShip := Ship named: 'Axiom'.
	aShip chargeFuelUpTo: 1.
	
	self
		should: [aShip consumeFuel: 2]
		raise: Error
		withMessageText: 'Ship has no enough fuel for this consumption'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipHasTenUnitsOfFuelAndConsumesOneThenItHasNineUnitsOfFuel [

	| aShip |
	aShip := Ship named: 'Serenity'.
	aShip chargeFuelUpTo: 10.
	aShip consumeFuel: 1.
	
	self assert: (aShip currentFuel) equals: 9.
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsChargedWithANegativeAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Apolo'.
	
	self
		should: [aShip chargeFuelUpTo: -1]
		raise: Error
		"withMessageText: 'Ship must be charged with a positive amount of fuel.'"
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'.
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsChargedWithANonValidAmountOfFuelThenItFails [

	| aShip |
	aShip := Ship named: 'Elysium'.
	
	self
		should: [aShip chargeFuelUpTo: 'dos']
		raise: Error
		"withMessageText: 'Ship must be charged with a positive amount of fuel.'"
		withMessageText: 'Charge and consumption of fuel must be a positive amount.'.
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsChargedWithOneFuelUnitsThenItHasOneFuelUnit [

	| aShip |
	aShip := Ship named: 'Discovery One'.
	aShip chargeFuelUpTo: 1.
	
	self assert: (aShip currentFuel ) equals: 1.
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsCreatedThenItStarsAtStartingPosition [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	
	aShip := Ship named: 'Discovery One'.
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 20.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	"self assert: (aShip position) equals: 1."
	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsCreatedWithNoNameThenCreationFails [

	self
		should: [Ship named: '']
		raise: Error
		withMessageText: 'Ship must be initialized with a name.'
	
]

{ #category : 'tests' }
ShipTest >> testWhenShipIsInitializedThenItHasNotCompletedAnyLaps [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	aShip := Ship named: 'Venture'.
	numberOfCells := 10.
	 someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 2 and: 6.
    ships := OrderedCollection with: aShip.
    oneDice := ChargedDice withATotalNumberOfFacesOf: 10.  
    dices := OrderedCollection with: oneDice.
    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame updateLapFor: aShip withTotalSteps: 10.

	self assert: (aGame currentLapFor: aShip) equals: 1.
]

{ #category : 'tests' }
ShipTest >> testWhenShipMovesOnePositionFromStartingPositionThenItMovesAccordingly [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	aShip := Ship named: 'Discovery One'.
	"aShip chargeFuelUpTo: 5.
	
	aShip moveTo: 1 andConsume: 1."
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 20.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.
	
	aGame move: aShip to: 1 andConsume: 1.
	
	"self assert: (aShip position) equals: 1."
	self assert: (aGame positionOf: aShip) equals: 1.
]

{ #category : 'tests' }
ShipTest >> testWhenShipRunsOutOfFuelAndRestoresItThenItFillsUpTheTank [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame initialFuel |
	aShip := Ship named: 'Apolo'.
	
	"aShip chargeFuelUpTo: 5.
	aShip moveTo: 5 andConsume: 5."
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 20.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	initialFuel := aShip currentFuel.
	aGame move: aShip to: 5 andConsume: 5.
	aShip restoreFuel.
	
	self assert: (aShip currentFuel ) equals: initialFuel.
]

{ #category : 'tests' }
ShipTest >> testWhenShipRunsOutOfFuelThenItStaysAtCurrentPosition [

	| aShip numberOfCells someProbabilities aCellGenerator aBoard ships oneDice dices aGame |
	aShip := Ship named: 'Axiom'.
	"aShip chargeFuelUpTo: 1.
	aShip moveTo: 1 andConsume: 1."
	
	numberOfCells := 20.
	someProbabilities := Dictionary new
        at: 1 put: (NormalCell initializeCellOn: numberOfCells) ;
        yourself.
	 aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	 aBoard := Board withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: 17 and: 20.
	ships := OrderedCollection with: aShip.

	oneDice := ChargedDice withATotalNumberOfFacesOf: 5. 
	dices := OrderedCollection with: oneDice.

    aGame := SpaceShipGame
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

	aGame move: aShip to: 1 andConsume: 1.
	
	self assert: (aGame positionOf: aShip) equals: (aShip lastPosition).
]
