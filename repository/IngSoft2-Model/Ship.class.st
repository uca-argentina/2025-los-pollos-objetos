Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'shipsCurrentCell',
		'fuelCharged',
		'maximumFuel',
		'shipsCurrentLap',
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

	^ (self new initializeWith: aName) atStartingPosition.
]

{ #category : 'instance creation' }
Ship class >> shipHasAValidName: aName [

	(aName isEmpty or: [ aName isNil ]) ifTrue: [
		Error signal: 'Ship must be initialized with a name.' ]
]

{ #category : 'accessing' }
Ship >> atStartingPosition [
	
	shipsCurrentCell := 0.
	shipsPreviousCell := 0.
	shipsCurrentLap := 0.
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

{ #category : 'path commands' }
Ship >> currentCharge [

	^ fuelCharged.
	
]

{ #category : 'accessing' }
Ship >> currentLap [

	^ shipsCurrentLap.
]

{ #category : 'path commands' }
Ship >> hasEnoughFuel: aConsumption [

	(aConsumption > fuelCharged) ifTrue: 
		[Error signal: 'Ship has no enough fuel for this consumption' ]
	
]

{ #category : 'accessing' }
Ship >> initializeWith: aName [

	shipsName := aName.
]

{ #category : 'accessing' }
Ship >> isAPositiveInteger: aChargeOfFuel [

	(aChargeOfFuel isInteger and: [ aChargeOfFuel > 0 ]) ifFalse: [
		Error signal: 'Charge and consumption of fuel must be a positive amount.' ]
]

{ #category : 'accessing' }
Ship >> lastPosition [
	
	^ shipsPreviousCell .
]

{ #category : 'path commands' }
Ship >> moveTo: newPosition andConsume: aConsumption [ 

	self consumeFuel: aConsumption.
   fuelCharged = 0 ifTrue: [ ^self ].

   shipsPreviousCell := shipsCurrentCell.
   shipsCurrentCell := newPosition.
]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName.
]

{ #category : 'accessing' }
Ship >> position [
	
	^ shipsCurrentCell.
]

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuelCharged := maximumFuel.
	
]

{ #category : 'accessing' }
Ship >> updateLapOn: aNumberOfLap [

	shipsCurrentLap := shipsCurrentLap + aNumberOfLap.



	
	
]
