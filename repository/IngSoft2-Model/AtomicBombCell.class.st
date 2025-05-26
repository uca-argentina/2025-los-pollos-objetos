Class {
	#name : 'AtomicBombCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomicBombCell >> applyEffectTo: aShip of: aGame [

	"Devuelve a todas las naves a la posición inicial y restaura el combustible de cada una"
    aGame ships do: [:eachShip | 
        eachShip atStartingPosition.
        eachShip restoreFuel.
    ].
]
