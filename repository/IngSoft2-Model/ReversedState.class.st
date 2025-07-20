Class {
	#name : 'ReversedState',
	#superclass : 'CellState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ReversedState >> applyEffectTo: aShip in: aCell from: aGame [

	(aGame isReversed: aShip)
	ifTrue: [ aCell applyReversedEffectTo: aShip from: aGame ]
	ifFalse: [ aCell applyEffectTo: aShip of: aGame ] .
]

{ #category : 'as yet unclassified' }
ReversedState >> reversedVersion [ 
	
	^ NormalState new.
]
