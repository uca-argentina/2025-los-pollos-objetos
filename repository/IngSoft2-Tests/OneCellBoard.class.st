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

	^ self new initializeWith: 1.
]

{ #category : 'initialization' }
OneCellBoard >> blackHolesFirstEntrance [

	^ blackHolesFirstEntrance.
]

{ #category : 'initialization' }
OneCellBoard >> blackHolesSecondEntrance [

	^ blackHolesSecondEntrance.
]

{ #category : 'initialization' }
OneCellBoard >> initializeWith: aNumberOfCells [

	totalBoardCells := aNumberOfCells.
	blackHolesFirstEntrance := 0.
	blackHolesSecondEntrance := 0.
]

{ #category : 'initialization' }
OneCellBoard >> numberOfCells [

	^ totalBoardCells 
]
