Class {
	#name : 'HyperGravityCell',
	#superclass : 'Cell',
	#instVars : [
		'requiredValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperGravityCell class >> initializeCellOn: aNumberOfCell withRequiredValue: aRequiredValue [

    self isAPositiveInteger: aNumberOfCell.
    self isAPositiveInteger: aRequiredValue.

    ^ (self new) setUpOn: aNumberOfCell withRequiredValue: aRequiredValue
]

{ #category : 'initialization' }
HyperGravityCell >> applyEffectTo: aShip of: aGame [
    | diceThrow |
    diceThrow := aGame lastDiceThrow.
    (diceThrow >= requiredValue)
        ifFalse: [
            aShip setPositionBeforePlay: aGame positionBeforePlay
                andFuel: aGame fuelBeforePlay ].
]

{ #category : 'initialization' }
HyperGravityCell >> setUpOn: aNumberOfCell withRequiredValue: aRequiredValue [

    ships := OrderedCollection new.
    numberOfCell := aNumberOfCell.
    requiredValue := aRequiredValue.
    ^ self
]
