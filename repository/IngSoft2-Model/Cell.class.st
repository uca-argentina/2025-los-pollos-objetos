Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'numberOfCell',
		'state'
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

{ #category : 'initialization' }
Cell >> currentState [ 

	^ state.
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
	state := NormalState new.
]

{ #category : 'initialization' }
Cell >> transitionToState: aState [
	
	state := aState.
]

{ #category : 'initialization' }
Cell >> withPositionNumber: aPositionNumber [

	numberOfCell := aPositionNumber.
]
