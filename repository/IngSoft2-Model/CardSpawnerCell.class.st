Class {
	#name : 'CardSpawnerCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardSpawnerCell >> applyEffectTo: aShip of: aGame [
	
	aGame pickACardFor: aShip.
]

{ #category : 'initialization' }
CardSpawnerCell >> applyReversedEffectTo: aShip from: aGame [ 

	| shipsToAffect |
	shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = aShip].
	shipsToAffect do: [ :ship | aGame pickACardFor: ship ].
]

{ #category : 'initialization' }
CardSpawnerCell >> decideEffectoBasedOnStateOf: aShip of: aGame [

	(aGame isReversed: aShip)
	ifTrue: [ self applyReversedEffectTo: aShip from: aGame ]
	ifFalse: [ self applyEffectTo: aShip of: aGame ] .
]
