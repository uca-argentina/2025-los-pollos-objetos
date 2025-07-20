Class {
	#name : 'HyperJumpCell',
	#superclass : 'Cell',
	#instVars : [
		'boardLengthInParsecs',
		'cellLengthInParsecs',
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

	| instance |
	self distanceValueIsValid: distanceValues.
	self isAPositiveInteger: aNumberOfCell and: (aBoardLength valueInParsecs) and: aNumberOfCells.
	instance := super initializeCellOn: aNumberOfCell.
	
	^ instance withDistanceValues: distanceValues withBoardLength: aBoardLength withANumberOfCells: aNumberOfCells.
]

{ #category : 'initialization' }
HyperJumpCell class >> initializeCellOn: aNumberOfCell withParsecValues: aParsecValue boardLength: aBoardLengthInParsecs numberOfCells: aNumberOfCells [

	| parsecDistanceValues boardLenght instance |
	parsecDistanceValues:= OrderedCollection new.
	aParsecValue do: [ :val | parsecDistanceValues add: (ParsecDistance with: val) ].
	
	boardLenght := ParsecDistance with: aBoardLengthInParsecs.

	self distanceValueIsValid: parsecDistanceValues.
	self isAPositiveInteger: aNumberOfCell and: aBoardLengthInParsecs and: aNumberOfCells.
	
	instance := super initializeCellOn: aNumberOfCell.
	^ instance withDistanceValues: parsecDistanceValues withBoardLength: boardLenght withANumberOfCells: aNumberOfCells.
]

{ #category : 'initialization' }
HyperJumpCell class >> isAPositiveInteger: aNumberOfCells and: aBoardLenghtInParsecs and: totalNumberOfCells [

	(aNumberOfCells > 0 and: (aBoardLenghtInParsecs > 0 and: totalNumberOfCells > 0)) ifFalse: [
		Error signal:
			'Number of cells, board lenght in parsecs and total number of cells must be a positive integer.' ]
]

{ #category : 'initialization' }
HyperJumpCell >> applyEffectTo: aShip of: aGame [
	
	aGame move: aShip by: (self cellsToJump).
   self updateDistanceIndex.
]

{ #category : 'initialization' }
HyperJumpCell >> applyReversedEffectTo: aShip from: aGame [

	| shipsToAffect |
	shipsToAffect := aGame shipsPlaying reject: [ :ship | ship = aShip].
	shipsToAffect do: [ :ship | aGame move: ship by: (self cellsToJump) ].
]

{ #category : 'initialization' }
HyperJumpCell >> cellsToJump [

    | distanceToJump cellsToJump |
	
	distanceToJump := someDistanceValues at: currentDistanceIndex.
   ^ cellsToJump := (distanceToJump valueInParsecs) // cellLengthInParsecs.
]

{ #category : 'initialization' }
HyperJumpCell >> updateDistanceIndex [

    currentDistanceIndex := (currentDistanceIndex \\ someDistanceValues size) + 1.
]

{ #category : 'initialization' }
HyperJumpCell >> withDistanceValues: distanceValues withBoardLength: aBoardLength withANumberOfCells: aNumberOfCells [

	someDistanceValues := distanceValues.
	currentDistanceIndex := 1.
	boardLengthInParsecs := aBoardLength valueInParsecs .
	cellLengthInParsecs := boardLengthInParsecs // aNumberOfCells.
]
