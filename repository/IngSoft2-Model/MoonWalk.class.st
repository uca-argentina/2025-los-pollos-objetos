Class {
	#name : 'MoonWalk',
	#superclass : 'Cell',
	#instVars : [
		'requiredValue',
		'n'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalk class >> initializeCellOn: aNumberOfCell withRequiredValue: aRequiredValue [

    self isAPositiveInteger: aNumberOfCell.
    self isAPositiveInteger: aRequiredValue.

    ^ (self new) setUpOn: aNumberOfCell withRequiredValue: aRequiredValue
]

{ #category : 'initialization' }
MoonWalk class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
        Error signal: 'Required value must be a positive integer.' ].
]

{ #category : 'initialization' }
MoonWalk >> applyEffectTo: curentShip of: aGame [

	| shipsInGame |
	shipsInGame := aGame shipsPlaying.

	shipsInGame do:[:shipInGame |( ships includes: shipInGame ) ifFalse: [
			
			n >= shipInGame currentFuel 
			
			ifTrue:[
				shipInGame chargeFuelUpTo: aGame numberOfCells + 1.
				shipInGame moveTo: 1 andConsume: aGame numberOfCells.
				aGame penalize: shipInGame withTurns: 2. 
				] 
			
			ifFalse: [ 
				shipInGame moveTo: shipInGame position - n andConsume: n 
				]
			
			] 
		].

]

{ #category : 'initialization' }
MoonWalk >> setUpOn: aNumberOfCell withRequiredValue: aRequiredValue [

    ships := OrderedCollection new.
    numberOfCell := aNumberOfCell.
    n := aRequiredValue.
    ^ self
]
