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
	
	^ (self new) initializeWith: aName with: aBoard with: dices with: ships.   
]

{ #category : 'as yet unclassified' }
Game >> determineTheConsequencesOfTheThrowIn: aNewPosition forShip: aShip [
	
	(aNewPosition = winningCell ) ifTrue: [ ^ aShip name , ' won the Game!' ].
	
	"
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip fly: distanceFromBlackHolesFirstEntranceToSecondEntrance ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip fly: (distanceFromBlackHolesFirstEntranceToSecondEntrance * (-1))].	
	"
	
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip moveTo: blackHoleSecondEntrance ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip moveTo: blackHolesFirstEntrance ].	
	
	
]

{ #category : 'initialization' }
Game >> initializeWith: gameName with: aBoard with: gameDices with: gameShips [ 

    name := gameName.

    board := aBoard.
    winningCell := board numberOfCells.
    blackHolesFirstEntrance := board blackHolesFirstEntrance.
    blackHoleSecondEntrance := board blackHolesSecondEntrance.

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

{ #category : 'as yet unclassified' }
Game >> throwDiceFor: aShip [

	| resultOfTheThrow |
	resultOfTheThrow := (dices collect: [ :dice | dice beThrown ]) sum.
	
	aShip moveTo: (resultOfTheThrow + aShip position).

]
