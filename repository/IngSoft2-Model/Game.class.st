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
		'distanceFromBlackHolesFirstEntranceToSecondEntrance',
		'chargeOfFuel',
		'winningLaps',
		'currentIndexForShipsTurns',
		'penalties'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> completedAtLap: aNumberOfLap with: aBoard and: dices and: ships [ 
	
	^ (self new) initializeWith: aNumberOfLap with: aBoard with: dices with: ships.   
]

{ #category : 'as yet unclassified' }
Game >> advanceTurn [ 

	currentIndexForShipsTurns := currentIndexForShipsTurns + 1.
	currentIndexForShipsTurns > ships size ifTrue: [ currentIndexForShipsTurns := 1 ].
	
]

{ #category : 'accessing' }
Game >> calculateTargetPositionFor: totalSteps [.

		^ totalSteps = 0
        ifTrue: [ 0 ]
        ifFalse: [
            (totalSteps \\ board numberOfCells = 0)
                ifTrue: [ board numberOfCells ]
                ifFalse: [ totalSteps \\ board numberOfCells ]
        ].

]

{ #category : 'as yet unclassified' }
Game >> chargeFuelToShipsUpTo: aChargeOfFuel [

    ships do: [:aShip | aShip chargeFuelUpTo: aChargeOfFuel ].


]

{ #category : 'as yet unclassified' }
Game >> determineTheConsequencesOfTheThrowIn: aNewPosition forShip: aShip [
	
	| aShipCurrentLap |

	aShipCurrentLap := aShip currentLap.
	(aShipCurrentLap = winningLaps ) ifTrue: [ ^ aShip name , ' won the Game!' ].
	
	"
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip fly: distanceFromBlackHolesFirstEntranceToSecondEntrance ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip fly: (distanceFromBlackHolesFirstEntranceToSecondEntrance * (-1))].	
	"
	
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip moveTo: blackHoleSecondEntrance andConsume: (blackHoleSecondEntrance - blackHolesFirstEntrance)].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip moveTo: blackHolesFirstEntrance andConsume: (blackHoleSecondEntrance - blackHolesFirstEntrance)].	
	
	
]

{ #category : 'as yet unclassified' }
Game >> executeTurn [
	"Reviso qué nave debería jugar ahora. Si tiene una penalización activa, le descuento un turno 	de castigo y paso a la siguiente. Sigo haciendo esto hasta encontrar una nave que esté 	habilitada para jugar."
	| ship |

	[
		ship := ships at: currentIndexForShipsTurns .
		(penalties includesKey: ship) and: [(penalties at: ship) > 0]
	] whileTrue: [
		self reducePenaltyFor: ship.
		self advanceTurn.
	].

	"Guardamos la nave que va a jugar"
	ship := ships at: currentIndexForShipsTurns.

	"Avanzamos el índice para el próximo turno"
	self advanceTurn.

	^ ship

]

{ #category : 'initialization' }
Game >> initializeWith: laps with: aBoard with: gameDices with: gameShips [ 

    winningLaps := laps.

    board := aBoard.
	 board getShipsIntoFirstCellOfTheBoard: gameShips.
    "winningCell := board numberOfCells."
    blackHolesFirstEntrance := board blackHolesFirstEntrance.
    blackHoleSecondEntrance := board blackHolesSecondEntrance.

    dices := gameDices.
	 chargeOfFuel := (self sumOfDiceSizes) * 2.

    ships := gameShips.
	 self chargeFuelToShipsUpTo: chargeOfFuel.
	
	currentIndexForShipsTurns := 1.
	penalties := Dictionary new.
	
	 

]

{ #category : 'testing' }
Game >> isAPositiveInteger: numberOfFaces [

	(numberOfFaces isInteger and: [ numberOfFaces > 0 ]) ifFalse: [
		Error signal: 'The penalty must be a positive integer.' ]
]

{ #category : 'accessing' }
Game >> move: aShip to: targetPosition andConsume: aConsumption [

	| shipsPreviousPosition shipsNewPosition |
	aShip moveTo: targetPosition andConsume: aConsumption.
	
	shipsPreviousPosition := aShip lastPosition.
	shipsNewPosition := aShip position.
	
	board removeShip: aShip fromCellAt: shipsPreviousPosition.
	board addShip: aShip toCellAt: shipsNewPosition.
]

{ #category : 'as yet unclassified' }
Game >> penalize: aShip withTurns: nTurns [
	"Busco en el diccionario apenalties si la nave esta y le agrego los turnos de castigo, si no esta 
	la agrego al dicionario con sus respectivos castigos"
	self isAPositiveInteger: nTurns.
	penalties at: aShip put: (penalties at: aShip ifAbsent: [ 0 ]) + nTurns.

]

{ #category : 'as yet unclassified' }
Game >> penaltyFor: aShip [ 
	^ penalties at: aShip.
]

{ #category : 'as yet unclassified' }
Game >> reducePenaltyFor: aShip [
	| remaining |
	remaining := (penalties at: aShip) - 1.
	remaining > 0
		ifTrue: [ penalties at: aShip put: remaining ]
		ifFalse: [ penalties removeKey: aShip ].

]

{ #category : 'accessing' }
Game >> start [

	^ 'The Game Has Started'
]

{ #category : 'as yet unclassified' }
Game >> sumOfDiceSizes [

    ^ dices inject: 0 into: [ :sum :aDie | sum + aDie sizeOfTheDice ].


]

{ #category : 'as yet unclassified' }
Game >> throwDiceFor: aShip [
 
    | resultOfTheThrow totalSteps targetPosition |
    
    resultOfTheThrow := (dices collect: [ :dice | dice beThrown ]) sum.
    totalSteps := aShip position + resultOfTheThrow.

    targetPosition := self calculateTargetPositionFor: totalSteps.

    self move: aShip to: targetPosition  
         andConsume: resultOfTheThrow.

	 self updateLapFor: aShip withTotalSteps: totalSteps.

]

{ #category : 'as yet unclassified' }
Game >> updateLapFor: aShip withTotalSteps: totalSteps [
	
	 aShip updateLapOn: totalSteps // board numberOfCells.

]

{ #category : 'accessing' }
Game >> winningLap [

	^ winningLaps
]
