Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName',
		'fuelCharged',
		'maximumFuel',
		'throwAdjustment',
		'ally'
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
	ally := aShip .
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

{ #category : 'as yet unclassified' }
Ship >> disableAlly [
	ally ifNotNil: [  
		ally haveAllianceWith = self ifTrue: [ ally setAllyToNil ].
		self setAllyToNil.
		]
	

]

{ #category : 'path commands' }
Ship >> hasEnoughFuel: aConsumption [

	(aConsumption > fuelCharged) ifTrue: 
		[Error signal: 'Ship has no enough fuel for this consumption' ]
	
]

{ #category : 'as yet unclassified' }
Ship >> haveAllianceWith [
	^ ally 
]

{ #category : 'accessing' }
Ship >> initializeWith: aShipName andAFuelCharge: aFuelCharge [

	shipsName := aShipName.
	fuelCharged := aFuelCharge.
	maximumFuel := aFuelCharge.
	throwAdjustment:=0.
	ally := nil.
	
	
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

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuelCharged := maximumFuel.
	
]

{ #category : 'initialization' }
Ship >> setAllyToNil [ 
	ally := nil.

]
