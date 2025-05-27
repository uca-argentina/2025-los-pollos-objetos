Class {
	#name : 'HyperJumpCell',
	#superclass : 'Cell',
	#instVars : [
		'parsecValues',
		'boardLengthInParsecs',
		'cellLengthInParsecs',
		'currentParsecIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJumpCell class >> initializeCellOn: aNumberOfCell withParsecValues: aParsecValue boardLength: aBoardLengthInParsecs numberOfCells: aNumberOfCells [

	self parsecValueIsValid: aParsecValue.

	^ (self new) setUpOn: aNumberOfCell withParsecValues: aParsecValue withBoardLength: aBoardLengthInParsecs withANumberOfCells: aNumberOfCells
]

{ #category : 'initialization' }
HyperJumpCell class >> parsecValueIsValid: aParsecValue [

	aParsecValue isEmpty ifTrue: [ Error signal: 'Parsec values must be a non-empty array.' ].
]

{ #category : 'initialization' }
HyperJumpCell >> applyEffectTo: aShip of: aGame [

    | parsecsToJump casillerosASaltar nuevaPosicion |

    parsecsToJump := parsecValues at: currentParsecIndex.
    casillerosASaltar := parsecsToJump // cellLengthInParsecs.
    nuevaPosicion := aGame calculateTargetPositionFor: (aShip position + casillerosASaltar).
    aGame move: aShip to: nuevaPosicion andConsume: casillerosASaltar.

    "Actualizar índice para el próximo salto"
    currentParsecIndex := currentParsecIndex + 1.
    (currentParsecIndex > parsecValues size) ifTrue: [ currentParsecIndex := 1 ].
]

{ #category : 'initialization' }
HyperJumpCell >> setUpOn: aNumberOfCell withParsecValues: aParsecValue withBoardLength: aBoardLengthInParsecs withANumberOfCells: aNumberOfCells [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
	parsecValues := aParsecValue.
	currentParsecIndex := 1.
	boardLengthInParsecs := aBoardLengthInParsecs.
	cellLengthInParsecs := boardLengthInParsecs // aNumberOfCells.
	^ self
]
