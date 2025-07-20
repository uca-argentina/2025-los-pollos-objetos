Class {
	#name : 'BlackHoleCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleCell >> applyEffectTo: aShip of: aGame [

	aGame move: aShip by: -4.
	aGame discardOneTurbineOf: aShip.
]

{ #category : 'as yet unclassified' }
BlackHoleCell >> applyReversedEffectTo: aShip from: aGame [

	| shipsToAffect |
	shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = aShip].
	shipsToAffect do: [ :ship | aGame move: ship by: -4.
										aGame discardOneTurbineOf: ship ].
]

{ #category : 'as yet unclassified' }
BlackHoleCell >> decideEffectoBasedOnStateOf: aShip of: aGame [

	(aGame isReversed: aShip)
	ifTrue: [ self applyReversedEffectTo: aShip from: aGame ]
	ifFalse: [ self applyEffectTo: aShip of: aGame ] .
]
