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

	| instance |
	instance := super initializeCellOn: aNumberOfCell.
	^ instance between: firstEntrance and: secondEntrance.
]

{ #category : 'initialization' }
WormHoleCell >> applyEffectTo: aShip of: aGame [
				
	(numberOfCell = wormsHoleFirstEntrance ) ifTrue: [ aGame move: aShip by: (wormsHoleSecondEntrance - wormsHoleFirstEntrance) ].
	(numberOfCell = wormsHoleSecondEntrance ) ifTrue: [ aGame move: aShip by: (wormsHoleFirstEntrance - wormsHoleSecondEntrance) ].
]

{ #category : 'initialization' }
WormHoleCell >> applyReversedEffectTo: aShip from: aGame [

	| shipsToAffect |
	shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = aShip].
	shipsToAffect do: [ :ship | (numberOfCell = wormsHoleFirstEntrance ) ifTrue: [ aGame move: ship to: (wormsHoleSecondEntrance) andConsume: (wormsHoleSecondEntrance - wormsHoleFirstEntrance) ].
										(numberOfCell = wormsHoleSecondEntrance ) ifTrue: [ aGame move: ship to: (wormsHoleFirstEntrance) andConsume: (wormsHoleSecondEntrance - wormsHoleFirstEntrance) ] ].
]

{ #category : 'initialization' }
WormHoleCell >> between: firstEntrance and: secondEntrance [

	wormsHoleFirstEntrance := firstEntrance.
	wormsHoleSecondEntrance := secondEntrance.
]
