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
