Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'fuelCharged',
		'maximumFuel',
		'shipsPreviousCell'
	],
	#classInstVars : [
		'shipsName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> named: aName [

	self shipHasAValidName: aName.
	^ (self new initializeWith: aName)
]

{ #category : 'instance creation' }
Ship class >> shipHasAValidName: arg1 [

	(arg1 isEmpty or: [ arg1 isNil ]) ifTrue: [
		Error signal: 'Ship must be initialized with a name.' ]
]

{ #category : 'accessing' }
Ship >> chargeFuelUpTo: aChargeOfFuel [

	self isAPositiveInteger: aChargeOfFuel.

	maximumFuel := aChargeOfFuel.
	fuelCharged := aChargeOfFuel.
	
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
Ship >> initializeWith: aShipName [

	shipsName := aShipName.
	shipsPreviousCell := 1.
	
]

{ #category : 'accessing' }
Ship >> isAPositiveInteger: aChargeOfFuel [

	(aChargeOfFuel isInteger and: [ aChargeOfFuel >= 0 ]) ifFalse: [
		Error signal: 'Charge and consumption of fuel must be a positive amount.' ]
]

{ #category : 'accessing' }
Ship >> lastPosition [
	
	^ shipsPreviousCell .
]

{ #category : 'path commands' }
Ship >> moveFrom: shipsPreviousPosition andConsume: aConsumption [.
	
	self consumeFuel: aConsumption.
	shipsPreviousCell := shipsPreviousPosition.
	

]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName
]

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuelCharged := maximumFuel.
	
]
