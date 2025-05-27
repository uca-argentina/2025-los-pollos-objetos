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
		"aShip setPositionBeforePlay: aGame positionBeforePlay andFuel: aGame fuelBeforePlay"
		aGame shipToLastPlay: aShip .
		
		 ]
		ifFalse: [
			targetPosition := aGame calculateTargetPositionFor: (aShip position - 4).
			aGame move: aShip to: targetPosition andConsume: 4 ]
]
