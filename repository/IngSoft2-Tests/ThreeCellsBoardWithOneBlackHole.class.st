Class {
	#name : 'ThreeCellsBoardWithOneBlackHole',
	#superclass : 'Object',
	#instVars : [
		'totalBoardCells',
		'blackHolesFirstEntrance',
		'blackHolesSecondEntrance'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
ThreeCellsBoardWithOneBlackHole class >> withThreeCellsAndOneBlackHole [

	| aBuilder |
	aBuilder := BoardBuilder new.
	aBuilder withCells: 3.
	aBuilder withBlackHoleFrom: 1 to: 2.
	
	^ aBuilder build.
]
