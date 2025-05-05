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
	
	^ self new  initializeWith: 3
		andABlackHoleBeweenCells: 1 
		and: 2.
]

{ #category : 'initialization' }
ThreeCellsBoardWithOneBlackHole >> blackHolesFirstEntrance [

	^ blackHolesFirstEntrance.
]

{ #category : 'initialization' }
ThreeCellsBoardWithOneBlackHole >> blackHolesSecondEntrance [

	^ blackHolesSecondEntrance.
]

{ #category : 'initialization' }
ThreeCellsBoardWithOneBlackHole >> initializeWith: numberOfCells andABlackHoleBeweenCells: firstEntrance and: secondEntrance [

	totalBoardCells := numberOfCells.
	blackHolesFirstEntrance := firstEntrance.
	blackHolesSecondEntrance := secondEntrance.
]

{ #category : 'initialization' }
ThreeCellsBoardWithOneBlackHole >> numberOfCells [

	^ totalBoardCells 
]
