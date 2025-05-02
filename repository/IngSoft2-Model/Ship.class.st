Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'shipsName'
	],
	#classInstVars : [
		'shipsName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> named: aName [ 
	
	^ (Ship new) initializeWith: aName.
]

{ #category : 'accessing' }
Ship >> initializeWith: aName [

	shipsName := aName.
]

{ #category : 'accessing' }
Ship >> name [

	^ shipsName.
]
