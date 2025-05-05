Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'name',
		'board',
		'dices',
		'ships',
		'winningCell',
		'blackHolesFirstEntrance',
		'blackHoleSecondEntrance',
		'distanceFromBlackHolesFirstEntranceToSecondEntrance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> named: aName with: aBoard and: dices and: ships [ 
	
	^ (self new) initializeWith: aName and: aBoard and: dices and: ships.   
]

{ #category : 'as yet unclassified' }
Game >> determineTheConsequencesOfTheThrowIn: aNewPosition forShip: aShip [
	
	(aNewPosition = winningCell ) ifTrue: [ ^ aShip name , ' won the Game!' ].
	
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip fly: distanceFromBlackHolesFirstEntranceToSecondEntrance ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip fly: (distanceFromBlackHolesFirstEntranceToSecondEntrance * (-1))].	
]

{ #category : 'initialization' }
Game >> initializeWith: gameName and: aBoard and: gameDices and: gameShips [ 

	name := gameName.
	
	board := aBoard.
	winningCell := board numberOfCells.
	blackHolesFirstEntrance := board blackHolesFirstEntrance.
	blackHoleSecondEntrance := board blackHolesSecondEntrance.
	distanceFromBlackHolesFirstEntranceToSecondEntrance := blackHoleSecondEntrance - blackHolesFirstEntrance. 
	
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
