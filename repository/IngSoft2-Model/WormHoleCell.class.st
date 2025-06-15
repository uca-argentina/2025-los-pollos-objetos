Class {
	#name : 'WormHoleCell',
	#superclass : 'Cell',
	#instVars : [
		'wormsHoleFirstEntrance',
		'wormsHoleSecondEntrance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHoleCell class >> on: aNumberOfCell between: firstEntrance and: secondEntrance [

	^ (self new) initializeOn: aNumberOfCell between: firstEntrance and: secondEntrance.
]

{ #category : 'initialization' }
WormHoleCell >> applyEffectTo: aShip of: aGame [

	(numberOfCell = wormsHoleFirstEntrance ) ifTrue: [ aGame move: aShip by: (wormsHoleSecondEntrance - wormsHoleFirstEntrance) ].
	(numberOfCell = wormsHoleSecondEntrance ) ifTrue: [ aGame move: aShip by: (wormsHoleFirstEntrance - wormsHoleSecondEntrance) ].	
]

{ #category : 'initialization' }
WormHoleCell >> initializeOn: aNumberOfCell between: firstEntrance and: secondEntrance [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
	wormsHoleFirstEntrance := firstEntrance.
	wormsHoleSecondEntrance := secondEntrance.
]
