Class {
	#name : 'BlackHoleCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleCell >> applyEffectTo: aShip of: aGame [

	| targetPosition |
	4 >= aShip currentFuel
		ifTrue: [
				aGame moveShipToLastPlay: aShip.
		 ]
		ifFalse: [
			targetPosition := aGame calculateTargetPositionFor: ((aGame positionOf: aShip) - 4).
			aGame move: aShip to: targetPosition andConsume: 4 ]
]
