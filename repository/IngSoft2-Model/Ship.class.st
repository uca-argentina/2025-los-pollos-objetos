Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'fuelCharged',
		'maximumFuel',
		'throwAdjustment',
		'ally',
		'allies'
	],
	#classInstVars : [
		'shipsName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> named: aName withAChargeBasedOn: someDices [

	| initialFuelCharge |
	self shipHasAValidName: aName.
	initialFuelCharge := (someDices
		                     inject: 0
		                     into: [ :sum :aDie | sum + aDie sizeOfTheDice ]) * 2.
	^ self new initializeWith: aName andAFuelCharge: initialFuelCharge.
]

{ #category : 'instance creation' }
Ship class >> shipHasAValidName: arg1 [

	(arg1 isEmpty or: [ arg1 isNil ]) ifTrue: [
		Error signal: 'Ship must be initialized with a name.' ]
]

{ #category : 'as yet unclassified' }
Ship >> AlliedWith: aShip [
	allies add: aShip .
]

{ #category : 'path commands' }
Ship >> consumeFuel: aConsumption [

	self isAPositiveInteger: aConsumption.
	self hasEnoughFuel: aConsumption.

	fuelCharged := fuelCharged - aConsumption.
	
]

{ #category : 'as yet unclassified' }
Ship >> currentFuel [

	^ fuelCharged
]

{ #category : 'initialization' }
Ship >> deleteAllianceWith: aShip [
	allies remove: aShip.

]

{ #category : 'path commands' }
Ship >> hasEnoughFuel: aConsumption [

	(aConsumption > fuelCharged) ifTrue: 
		[Error signal: 'Ship has no enough fuel for this consumption' ]
	
]

{ #category : 'as yet unclassified' }
Ship >> inAllianceWith [
	^ allies. 
]

{ #category : 'accessing' }
Ship >> initializeWith: aShipName andAFuelCharge: aFuelCharge [

	shipsName := aShipName.
	fuelCharged := aFuelCharge.
	maximumFuel := aFuelCharge.
	throwAdjustment:=0.
	allies := OrderedCollection new.
	
	
]

{ #category : 'accessing' }
Ship >> isAPositiveInteger: arg1 [

	(arg1 isInteger and: [ arg1 >= 0 ]) ifFalse: [
		Error signal:
			'Charge and consumption of fuel must be a positive amount.' ]
]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName
]

{ #category : 'as yet unclassified' }
Ship >> receiveReward [
	fuelCharged := fuelCharged + 1. 
]

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuelCharged := maximumFuel.
	
]
