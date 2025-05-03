Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'name',
		'board',
		'dices',
		'ships',
		'winningCell'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> named: aName with: aBoard and: dices and: ships [ 
	
	^ (self new) initializeWith: aName and: aBoard and: dices and: ships.   
]

{ #category : 'as yet unclassified' }
Game >> checkResultOfTheThrow: aNewPosition [

	(aNewPosition = winningCell ) ifTrue: [ ^'The game has ended, you won!' ].
]

{ #category : 'initialization' }
Game >> initializeWith: gameName and: aBoard and: gameDices and: gameShips [ 

	name := gameName.
	
	board := aBoard.
	
	winningCell := board numberOfCells.
	
	dices := gameDices.
	
	ships := gameShips. 
]

{ #category : 'accessing' }
Game >> name [
	^ name.
]

{ #category : 'accessing' }
Game >> start [
	^ 'The Game Has Started'
]
