Class {
	#name : 'NormalState',
	#superclass : 'CellState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NormalState >> applyEffectTo: aShip in: aCell from: aGame [

	aCell applyEffectTo: aShip of: aGame.
]

{ #category : 'as yet unclassified' }
NormalState >> reversedVersion [

	^ ReversedState new.
]
