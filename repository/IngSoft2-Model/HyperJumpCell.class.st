Class {
	#name : 'HyperJumpCell',
	#superclass : 'Cell',
	#instVars : [
		'parsecValues',
		'boardLengthInParsecs',
		'cellLengthInParsecs',
		'currentParsecIndex',
		'someDistanceValues',
		'currentDistanceIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJumpCell class >> initializeCellOn: aNumberOfCell withDistanceValues: distanceValues boardLength: aBoardLengthInParsecs numberOfCells: aNumberOfCells [

	"self parsecValueIsValid: aParsecValue."
	self isAPositiveInteger: aNumberOfCell and: aBoardLengthInParsecs and: aNumberOfCells.

	^ (self new) setUpOn: aNumberOfCell withDistanceValues: distanceValues withBoardLength: aBoardLengthInParsecs withANumberOfCells: aNumberOfCells
]

{ #category : 'initialization' }
HyperJumpCell class >> initializeCellOn: aNumberOfCell withParsecValues: aParsecValue boardLength: aBoardLengthInParsecs numberOfCells: aNumberOfCells [

	self parsecValueIsValid: aParsecValue.
	self isAPositiveInteger: aNumberOfCell and: aBoardLengthInParsecs and: aNumberOfCells.

	^ (self new) setUpOn: aNumberOfCell withParsecValues: aParsecValue withBoardLength: aBoardLengthInParsecs withANumberOfCells: aNumberOfCells
]

{ #category : 'initialization' }
HyperJumpCell class >> isAPositiveInteger: aNumberOfCell and: aBoardLengthInParsecs and: totalNumberOfCells [

	(aNumberOfCell > 0 and: (aBoardLengthInParsecs > 0 and:
		 totalNumberOfCells > 0)) ifFalse: [
		Error signal:
			'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.' ]
]

{ #category : 'initialization' }
HyperJumpCell class >> parsecValueIsValid: aParsecValues [

	aParsecValues isEmpty ifTrue: [ Error signal: 'Parsec values must be a non-empty array.' ].
	(aParsecValues anySatisfy: [ :val | (val isInteger not)]) ifTrue: [ Error signal: 'All parsec values must be integers.' ].
]

{ #category : 'initialization' }
HyperJumpCell >> applyEffectTo: aShip of: aGame [

    | cellsToJump distanceToJump |

    distanceToJump := someDistanceValues at: currentDistanceIndex.
    cellsToJump := (distanceToJump valueInParsecs) // cellLengthInParsecs.
	 aGame move: aShip by: cellsToJump.

    currentDistanceIndex := (currentDistanceIndex \\ someDistanceValues size) + 1.
]

{ #category : 'initialization' }
HyperJumpCell >> setUpOn: aNumberOfCell withDistanceValues: distanceValues withBoardLength: aBoardLengthInParsecs withANumberOfCells: aNumberOfCells [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
	someDistanceValues := distanceValues.
	currentDistanceIndex := 1.
	boardLengthInParsecs := aBoardLengthInParsecs.
	cellLengthInParsecs := boardLengthInParsecs // aNumberOfCells.
]

{ #category : 'initialization' }
HyperJumpCell >> setUpOn: aNumberOfCell withParsecValues: aParsecValue withBoardLength: aBoardLengthInParsecs withANumberOfCells: aNumberOfCells [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
	parsecValues := aParsecValue.
	currentParsecIndex := 1.
	boardLengthInParsecs := aBoardLengthInParsecs.
	cellLengthInParsecs := boardLengthInParsecs // aNumberOfCells.
]
