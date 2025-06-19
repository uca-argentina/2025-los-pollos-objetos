Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'numberOfCell'
	],
	#classInstVars : [
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Cell class >> initializeCellOn: aNumberOfCell [

	self isAPositiveInteger: aNumberOfCell.

	^ (self new) setUpOn: aNumberOfCell.
]

{ #category : 'initialization' }
Cell class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
        Error signal: 'Number of cell must be a positive integer.' ].
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

{ #category : 'as yet unclassified' }
Cell >> number [

	^ numberOfCell.
]

{ #category : 'initialization' }
Cell >> setUpOn: aNumberOfCell [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
]

{ #category : 'initialization' }
Cell >> withPositionNumber: aPositionNumber [

	numberOfCell := aPositionNumber.
]
