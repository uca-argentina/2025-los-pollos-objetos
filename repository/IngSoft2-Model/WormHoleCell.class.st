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

	^ (self new) setUpOn: aNumberOfCell between: firstEntrance and: secondEntrance.
]

{ #category : 'initialization' }
WormHoleCell >> applyEffectTo: aShip of: aGame [
	
	(aGame isReversed: aShip)
	ifTrue: [ self applyReversedEffectTo: aShip from: aGame ] 
	ifFalse: [ (numberOfCell = wormsHoleFirstEntrance ) ifTrue: [ aGame move: aShip by: (wormsHoleSecondEntrance - wormsHoleFirstEntrance) ].
				  (numberOfCell = wormsHoleSecondEntrance ) ifTrue: [ aGame move: aShip by: (wormsHoleFirstEntrance - wormsHoleSecondEntrance) ].	 ].
]

{ #category : 'initialization' }
WormHoleCell >> applyReversedEffectTo: aShip from: aGame [

	| shipsToAffect |
	shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = aShip].
	shipsToAffect do: [ :ship | (numberOfCell = wormsHoleFirstEntrance ) ifTrue: [ aGame move: ship to: (wormsHoleSecondEntrance) andConsume: 0 ].
										(numberOfCell = wormsHoleSecondEntrance ) ifTrue: [ aGame move: ship to: (wormsHoleFirstEntrance) andConsume: 0].]
]

{ #category : 'initialization' }
WormHoleCell >> setUpOn: aNumberOfCell between: firstEntrance and: secondEntrance [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
	wormsHoleFirstEntrance := firstEntrance.
	wormsHoleSecondEntrance := secondEntrance.
]
