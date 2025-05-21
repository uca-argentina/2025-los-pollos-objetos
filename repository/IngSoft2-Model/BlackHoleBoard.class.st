Class {
	#name : 'BlackHoleBoard',
	#superclass : 'BoardDecorator',
	#instVars : [
		'firstEntrance',
		'secondEntrance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleBoard class >> of: aBoard from: firstCell to: secondCell [
	^ self new initializeOf: aBoard from: firstCell to: secondCell.
]

{ #category : 'initialization' }
BlackHoleBoard >> blackHolesFirstEntrance [

    ^ firstEntrance.
]

{ #category : 'initialization' }
BlackHoleBoard >> blackHolesSecondEntrance [

    ^ secondEntrance.
]

{ #category : 'initialization' }
BlackHoleBoard >> initializeOf: aBoard from: firstCell to: secondCell [

	baseBoard := aBoard.
	firstEntrance := firstCell.
	secondEntrance := secondCell.
]

{ #category : 'initialization' }
BlackHoleBoard >> numberOfCells [

	^ baseBoard numberOfCells.
]
