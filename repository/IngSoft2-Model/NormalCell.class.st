Class {
	#name : 'NormalCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
NormalCell >> applyEffectTo: aShip of: aGame [
]

{ #category : 'initialization' }
NormalCell >> applyReversedEffectTo: aShip from: aGame [
]

{ #category : 'initialization' }
NormalCell >> decideEffectoBasedOnStateOf: aShip of: aGame [

	(aGame isReversed: aShip)
	ifTrue: [ self applyReversedEffectTo: aShip from: aGame ]
	ifFalse: [ self applyEffectTo: aShip of: aGame ] .
]
