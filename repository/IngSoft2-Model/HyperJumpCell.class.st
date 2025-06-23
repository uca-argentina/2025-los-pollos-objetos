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
HyperJumpCell class >> distanceValueIsValid: distanceValues [

	distanceValues isEmpty ifTrue: [ Error signal: 'Distance values must be a non-empty array.' ].
	(distanceValues allSatisfy: [ :val | ((val valueInParsecs) isInteger)]) ifFalse: [ Error signal: 'All values must be integers.' ].
]

{ #category : 'initialization' }
HyperJumpCell class >> initializeCellOn: aNumberOfCell withDistanceValues: distanceValues boardLength: aBoardLength numberOfCells: aNumberOfCells [

	self distanceValueIsValid: distanceValues.
	self isAPositiveInteger: aNumberOfCell and: (aBoardLength valueInParsecs) and: aNumberOfCells.

	^ (self new) setUpOn: aNumberOfCell withDistanceValues: distanceValues withBoardLength: aBoardLength withANumberOfCells: aNumberOfCells
]

{ #category : 'initialization' }
HyperJumpCell class >> initializeCellOn: aNumberOfCell withParsecValues: aParsecValue boardLength: aBoardLengthInParsecs numberOfCells: aNumberOfCells [

	| parsecDistanceValues boardLenght |
	parsecDistanceValues:= OrderedCollection new.
	aParsecValue do: [ :val | parsecDistanceValues add: (ParsecDistance with: val) ].
	
	boardLenght := ParsecDistance with: aBoardLengthInParsecs.

	self distanceValueIsValid: parsecDistanceValues.
	self isAPositiveInteger: aNumberOfCell and: aBoardLengthInParsecs and: aNumberOfCells.

	^ (self new) setUpOn: aNumberOfCell withDistanceValues: parsecDistanceValues withBoardLength: boardLenght withANumberOfCells: aNumberOfCells
]

{ #category : 'initialization' }
HyperJumpCell class >> isAPositiveInteger: aNumberOfCell and: aBoardLengthInParsecs and: totalNumberOfCells [

	(aNumberOfCell > 0 and: (aBoardLengthInParsecs > 0 and:
		 totalNumberOfCells > 0)) ifFalse: [
		Error signal:
			'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.' ]
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
HyperJumpCell >> setUpOn: aNumberOfCell withDistanceValues: distanceValues withBoardLength: aBoardLength withANumberOfCells: aNumberOfCells [

	ships := OrderedCollection new.
	numberOfCell := aNumberOfCell.
	someDistanceValues := distanceValues.
	currentDistanceIndex := 1.
	boardLengthInParsecs := aBoardLength valueInParsecs .
	cellLengthInParsecs := boardLengthInParsecs // aNumberOfCells.
]
