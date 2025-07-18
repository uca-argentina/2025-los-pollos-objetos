Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'fuelCharged',
		'maximumFuel'
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
Ship class >> shipHasAValidName: aName [

	(aName isEmpty or: [ (aName size) < 1 ]) ifTrue: [
		Error signal: 'Ship must be initialized with a name.' ]
]

{ #category : 'path commands' }
Ship >> = anotherObject [

	^ (anotherObject isKindOf: Ship) and: [anotherObject name = self name].

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

{ #category : 'path commands' }
Ship >> hasEnoughFuel: aConsumption [

	(aConsumption > fuelCharged) ifTrue: 
		[Error signal: 'Ship has no enough fuel for this consumption' ]
	
]

{ #category : 'accessing' }
Ship >> initializeWith: aShipName andAFuelCharge: aFuelCharge [

	shipsName := aShipName.
	fuelCharged := aFuelCharge.
	maximumFuel := aFuelCharge.
	
	
]

{ #category : 'accessing' }
Ship >> isAPositiveInteger: aConsumption [

	(aConsumption isInteger and: [ aConsumption >= 0 ]) ifFalse: [
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
