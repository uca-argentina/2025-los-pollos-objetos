Class {
	#name : 'OneCellBoard',
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
OneCellBoard class >> withOneCell [

	^ BoardBuilder new withCells: 1;
		build.
]
