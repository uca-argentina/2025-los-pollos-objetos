Class {
	#name : 'SpaceShipGame',
	#superclass : 'Object',
	#instVars : [
		'name',
		'board',
		'dices',
		'ships',
		'winningCell',
		'blackHolesFirstEntrance',
		'blackHoleSecondEntrance',
		'distanceFromBlackHolesFirstEntranceToSecondEntrance',
		'chargeOfFuel',
		'winningLaps',
		'penalties',
		'shipSupposedToPlay',
		'positionBeforePlay',
		'fuelBeforePlay',
		'lastDiceThrow'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceShipGame class >> completedAtLap: aNumberOfLap with: aBoard and: dices and: ships [ 
	
	^ (self new) initializeWith: aNumberOfLap with: aBoard with: dices with: ships.   
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> advanceTurn [ 

	shipSupposedToPlay := shipSupposedToPlay + 1.
	shipSupposedToPlay > ships size ifTrue: [ shipSupposedToPlay := 1 ].
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> advanceTurnIfCurrentTurnsShipIsPenalized [

	| ship |
	
	[
	ship := ships at: shipSupposedToPlay.
	penalties includesKey: ship ] whileTrue: [
		self reducePenaltyFor: ship.
		self advanceTurn ].
	
	^ ship
]

{ #category : 'accessing' }
SpaceShipGame >> calculateTargetPositionFor: totalSteps [

	^ (totalSteps \\ board numberOfCells) = 0
        ifTrue: [ board numberOfCells ]
        ifFalse: [ totalSteps \\ board numberOfCells ].

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> chargeFuelToShipsUpTo: aChargeOfFuel [

    ships do: [:aShip | aShip chargeFuelUpTo: aChargeOfFuel ].


]

{ #category : 'as yet unclassified' }
SpaceShipGame >> determineTheConsequencesOfTheThrowIn: aNewPosition forShip: aShip [
	
	| aShipCurrentLap |

	aShipCurrentLap := aShip currentLap.
	(aShipCurrentLap = winningLaps ) ifTrue: [ ^ aShip name , ' won the Game!' ].
	
	"
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip fly: distanceFromBlackHolesFirstEntranceToSecondEntrance ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip fly: (distanceFromBlackHolesFirstEntranceToSecondEntrance * (-1))].	
	"

	"(aNewPosition = blackHolesFirstEntrance) ifTrue: [ self move: aShip to: blackHoleSecondEntrance andConsume: (blackHoleSecondEntrance - blackHolesFirstEntrance) ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ self move: aShip to: blackHolesFirstEntrance andConsume: (blackHoleSecondEntrance - blackHolesFirstEntrance) ]."	
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> executeTurn [

	| ship |
	
	ship := self advanceTurnIfCurrentTurnsShipIsPenalized.
	ship := ships at: shipSupposedToPlay.

	self throwDiceFor: ship.
	self advanceTurn.

	^ ship
]

{ #category : 'initialization' }
SpaceShipGame >> initializeWith: laps with: aBoard with: gameDices with: gameShips [ 

    winningLaps := laps.

    board := aBoard.
	 board getShipsIntoFirstCellOfTheBoard: gameShips.
    "winningCell := board numberOfCells."
    "blackHolesFirstEntrance := board wormsHolesFirstEntrance.
    blackHoleSecondEntrance := board wormsHolesSecondEntrance."

    dices := gameDices.
	 chargeOfFuel := (self sumOfDiceSizes) * 2.

    "ships := gameShips collect: [ :ship | ship deepCopy ]."
	 ships := gameShips.
	 self chargeFuelToShipsUpTo: chargeOfFuel.
	
	shipSupposedToPlay := 1.
	penalties := Dictionary new.
	
	 

]

{ #category : 'testing' }
SpaceShipGame >> isAPositiveInteger: numberOfFaces [

	(numberOfFaces isInteger and: [ numberOfFaces > 0 ]) ifFalse: [
		Error signal: 'The penalty must be a positive integer.' ]
]

{ #category : 'accessing' }
SpaceShipGame >> lastDiceThrow [

	^ lastDiceThrow 
]

{ #category : 'accessing' }
SpaceShipGame >> move: aShip to: targetPosition andConsume: aConsumption [

	| shipsPreviousPosition |
	
	"aShip moveTo: targetPosition andConsume: aConsumption."
	shipsPreviousPosition := self positionOf: aShip.
	aShip moveFrom: shipsPreviousPosition andConsume: aConsumption.
	
	aShip currentFuel = 0
		ifTrue: [ self penalize: aShip withTurns: 2 ]
		ifFalse: [
			board removeShip: aShip fromCellAt: shipsPreviousPosition.
			board addShip: aShip toCellAt: targetPosition ].
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> moveShipToLastPlay: aShip [

	self move: aShip to: positionBeforePlay andConsume: 0.
	aShip restoreFuel.
]

{ #category : 'initialization' }
SpaceShipGame >> numberOfCells [ 

	^ board  numberOfCells .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> penalize: aShip withTurns: numberOfTurns [
	
	self isAPositiveInteger: numberOfTurns.
	penalties at: aShip put: (penalties at: aShip ifAbsent: [ 0 ]) + numberOfTurns.

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> penaltyFor: aShip [ 

	^ penalties at: aShip.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> positionOf: aShip [

	^ ((board cells) detect: [ :cell | cell includes: aShip ]) number.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> reducePenaltyFor: aShip [

	| remaining |
remaining := (penalties at: aShip) - 1.
remaining > 0
	ifTrue: [ penalties at: aShip put: remaining ]
	ifFalse: [
		aShip restoreFuel.
		penalties removeKey: aShip ]

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> shipLike: aShip [

	^ (ships detect: [ :ship | (ship name) = (aShip name) ])
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> shipsPlaying [

	^ ships
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> skipTurnFor: aShip [

	self penalize: aShip withTurns: 1. 

]

{ #category : 'accessing' }
SpaceShipGame >> start [

	^ 'The Game Has Started'
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> sumOfDiceSizes [

    ^ dices inject: 0 into: [ :sum :aDie | sum + aDie sizeOfTheDice ].


]

{ #category : 'as yet unclassified' }
SpaceShipGame >> throwDiceFor: aShip [

	| resultOfTheThrow totalSteps targetPosition |
	
	positionBeforePlay := self positionOf: aShip.
	fuelBeforePlay := aShip currentFuel . 

	resultOfTheThrow := (dices collect: [ :dice | dice beThrown ]) sum.
	lastDiceThrow := resultOfTheThrow .
	
	totalSteps := (self positionOf: aShip) + resultOfTheThrow.
	targetPosition := self calculateTargetPositionFor: totalSteps.

	self move: aShip to: targetPosition andConsume: resultOfTheThrow.
	board checkCell: aShip of: self.
	self updateLapFor: aShip withTotalSteps: totalSteps.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> updateLapFor: aShip withTotalSteps: totalSteps [
	
	 aShip updateLapOn: totalSteps // board numberOfCells.

]

{ #category : 'accessing' }
SpaceShipGame >> winningLap [

	^ winningLaps
]
