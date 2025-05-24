Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'ships'
	],
	#classInstVars : [
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Cell class >> initializeCell [

	^ (self new) setUp.
]

{ #category : 'as yet unclassified' }
Cell >> enters: aShip [

	ships add: aShip.
]

{ #category : 'as yet unclassified' }
Cell >> includes: aShip [

	^ ships includes: aShip.
]

{ #category : 'as yet unclassified' }
Cell >> leaves: aShip [

	ships remove: aShip.
]

{ #category : 'initialization' }
Cell >> setUp [

	ships := OrderedCollection new.
]
