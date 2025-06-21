Class {
	#name : 'BlackHoleCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleCell >> applyEffectTo: aShip of: aGame [

	4 >= aShip currentFuel
		ifTrue: [
				aGame penalize: aShip withTurns: 2.
		 ] ifFalse: [
				aGame move: aShip by: (-4).]
]
