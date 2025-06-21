Class {
	#name : 'AtomicBombCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomicBombCell >> applyEffectTo: aShip of: aGame [

    aGame shipsPlaying do: [:eachShip | 
		 aGame returnToInitialPosition: eachShip
	].

]
