Class {
	#name : 'AtomicBombCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomicBombCell >> applyEffectTo: aShip of: aGame [

	(aGame isReversed: aShip)
	ifTrue: [ self applyReversedEffectTo: aShip from: aGame ] 
	ifFalse: [aGame shipsPlaying do: [ :eachShip | 
		 		aGame returnToInitialPosition: eachShip ]].

]

{ #category : 'initialization' }
AtomicBombCell >> applyReversedEffectTo: aShip from: aGame [

	^ self.
]
