Class {
	#name : 'CellState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CellState >> applyEffectTo: aCell in: aShip from: aGame [

	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
CellState >> reversedVersion [

	self subclassResponsibility.
]
