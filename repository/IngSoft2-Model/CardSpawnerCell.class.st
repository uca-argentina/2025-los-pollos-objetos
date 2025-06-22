Class {
	#name : 'CardSpawnerCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardSpawnerCell >> applyEffectTo: aShip of: aGame [

	aGame pickACardFor: aShip
]
