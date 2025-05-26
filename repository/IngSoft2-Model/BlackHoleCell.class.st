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
			aShip
				setPositionBeforePlay: aGame positionBeforePlay
				andFuel: aGame fuelBeforePlay ]
		ifFalse: [ aShip moveTo: aShip position - 4 andConsume: 4 ]
]
