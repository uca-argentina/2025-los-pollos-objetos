Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'shipsCurrentCell',
		'fuelCharged'
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
]

{ #category : 'accessing' }
Ship >> chargeFuelUpTo: aChargeOfFuel [

	fuelCharged := aChargeOfFuel.
]

{ #category : 'path commands' }
Ship >> consumeFuel: aConsumption [

	fuelCharged := fuelCharged - aConsumption.
	
]

{ #category : 'path commands' }
Ship >> currentCharge [

	^ fuelCharged.
	
]

{ #category : 'accessing' }
Ship >> initializeWith: aName [

	shipsName := aName.
]

{ #category : 'path commands' }
Ship >> moveTo:  newPosition [ 

	self consumeFuel: (newPosition - shipsCurrentCell) abs.
	shipsCurrentCell := newPosition .
	
]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName.
]

{ #category : 'accessing' }
Ship >> position [
	
	^ shipsCurrentCell.
]
