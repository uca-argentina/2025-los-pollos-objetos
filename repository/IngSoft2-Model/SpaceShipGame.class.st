Class {
	#name : 'SpaceShipGame',
	#superclass : 'Object',
	#instVars : [
		'board',
		'dices',
		'ships',
		'winningLaps',
		'penalties',
		'shipSupposedToPlay',
		'lastDiceThrow',
		'shipsCurrentLap',
		'deck',
		'cardManagers',
		'cardPlayHandler'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceShipGame class >> completedAtLap: aNumberOfLap with: aBoard and: dices and: ships [ 
	
	^ (self new) initializeWith: aNumberOfLap with: aBoard with: dices with: ships with: (Deck with: (OrderedCollection with: '')).
]

{ #category : 'as yet unclassified' }
SpaceShipGame class >> completedAtLap: aNumberOfLap with: aBoard and: dices and: ships and: aDeck [
	
	^ (self new) initializeWith: aNumberOfLap with: aBoard with: dices with: ships with: aDeck.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> advanceTurn [ 

	shipSupposedToPlay := (shipSupposedToPlay \\ ships size) + 1.
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

{ #category : 'as yet unclassified' }
SpaceShipGame >> allianceBewtween: cardOwner and: cardTarget [

	cardOwner AlliedWith: cardTarget .
	cardTarget AlliedWith: cardOwner .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> applyACardEffect: aCard to: aShip [

	(self cardManagerOf: aShip ) addCardsAffecting: aCard. 
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> applyToAllSpaceShips: aCard [

	cardManagers do: [ :cardManager | cardManager addCardsAffecting: aCard  ]
]

{ #category : 'accessing' }
SpaceShipGame >> calculateTargetPositionFor: totalSteps [

	^ (totalSteps \\ board numberOfCells) = 0
        ifTrue: [ board numberOfCells ]
        ifFalse: [ totalSteps \\ board numberOfCells ].

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> cardManagerOf: aShip [ 

	| aCardManager |
	aCardManager := cardManagers detect: [ :manager | manager ship = aShip ].
	^ aCardManager  .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> currentLapFor: aShip [

	^ shipsCurrentLap at: aShip.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> determineTheConsequencesOfTheThrowIn: aNewPosition forShip: aShip [
	
	| aShipCurrentLap |

	aShipCurrentLap := self currentLapFor: aShip.
	(aShipCurrentLap = winningLaps ) ifTrue: [ ^ aShip name , ' won the Game!' ].
	
	"
	(aNewPosition = blackHolesFirstEntrance) ifTrue: [ aShip fly: distanceFromBlackHolesFirstEntranceToSecondEntrance ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ aShip fly: (distanceFromBlackHolesFirstEntranceToSecondEntrance * (-1))].	
	"

	"(aNewPosition = blackHolesFirstEntrance) ifTrue: [ self move: aShip to: blackHoleSecondEntrance andConsume: (blackHoleSecondEntrance - blackHolesFirstEntrance) ].
	(aNewPosition = blackHoleSecondEntrance ) ifTrue: [ self move: aShip to: blackHolesFirstEntrance andConsume: (blackHoleSecondEntrance - blackHolesFirstEntrance) ]."	
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> disableAllianceof: aShip [

	aShip disableAlly.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> disableCard: aCard from: aShip to: anotherShip [

	cardPlayHandler handleDisable: aCard from: aShip to: anotherShip .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> discardACardEffect: aCard [ 

	cardManagers do: [ :cardManager | cardManager deleteCardsAffecting: aCard  ] 
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> executeTurn [

	| ship |
	
	ship := self advanceTurnIfCurrentTurnsShipIsPenalized.
	ship := ships at: shipSupposedToPlay.

	self throwDiceFor: ship.
	board determineAndApplyEffectTo: ship atCurrentCellFrom: self.
	self advanceTurn.

	^ ship
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> handleMoveWithoutFuelOf: aShip to: targetPosition consuming: aConsumption [ 
	aShip haveAllianceWith isNil
		ifTrue: [ self penalize: aShip withTurns: 2 ]
		ifFalse: [ self tryToMoveUsingAllyOf: aShip to: targetPosition consuming: aConsumption ].

]

{ #category : 'initialization' }
SpaceShipGame >> initializeWith: laps with: aBoard with: gameDices with: gameShips with: aDeck [

 

winningLaps := laps.

	dices := gameDices.
	
	deck:= aDeck.
	cardManagers := gameShips collect: [ :aShip | CardManager of: aShip with:aDeck ].
	cardPlayHandler:= CardPlayHandler with: self.
	

	"ships := gameShips collect: [ :ship | ship deepCopy ]."
	 ships := gameShips.
	
   board := aBoard.
	board getShipsIntoFirstCellOfTheBoard: gameShips.
   "winningCell := board numberOfCells."
   "blackHolesFirstEntrance := board wormsHolesFirstEntrance.
   blackHoleSecondEntrance := board wormsHolesSecondEntrance."
	
	shipSupposedToPlay := 1.
	penalties := Dictionary new.
	shipsCurrentLap := Dictionary new.
	ships do: [ :ship | shipsCurrentLap at: ship put: 0 ].

]

{ #category : 'testing' }
SpaceShipGame >> isAPositiveInteger: numberOfFaces [

	(numberOfFaces isInteger and: [ numberOfFaces > 0 ]) ifFalse: [
		Error signal: 'The penalty must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> isShipSupposedToPLay: aShip [

	aShip = (ships at: shipSupposedToPlay ) ifFalse: [ Error signal: 'You can only play this card when its your turn' ]
]

{ #category : 'accessing' }
SpaceShipGame >> lastDiceThrow [

	^ lastDiceThrow 
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> modifyThrowFor: aShip [


	^ (self cardManagerOf: aShip ) applyEffect.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> move: aShip by: steps [

	| totalSteps targetPosition aConsumption |
	totalSteps := (self positionOf: aShip) + steps.
	targetPosition := self calculateTargetPositionFor: totalSteps.

	aConsumption := steps abs.
	self move: aShip to: targetPosition andConsume: aConsumption.
	self updateLapFor: aShip withTotalSteps: totalSteps.
]

{ #category : 'accessing' }
SpaceShipGame >> move: aShip to: targetPosition andConsume: aConsumption [

	aShip currentFuel > aConsumption
		ifTrue: [ 
			self moveShip: aShip to: targetPosition consuming: aConsumption 
		]
		ifFalse: [ 
			self handleMoveWithoutFuelOf: aShip to: targetPosition consuming: aConsumption 
		].

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> moveShip: aShip to: targetPosition consuming: aConsumption [ 
	aShip consumeFuel: aConsumption.
	self performMoveOf: aShip to: targetPosition.

]

{ #category : 'initialization' }
SpaceShipGame >> numberOfCells [ 

	^ board  numberOfCells .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> penalize: aShip withTurns: numberOfTurns [
	
	self isAPositiveInteger: numberOfTurns.
	penalties at: aShip put: (penalties at: aShip ifAbsent: [ 0 ]) + numberOfTurns.
	self returnToInitialPosition: aShip.

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> penaltyFor: aShip [ 

	^ penalties at: aShip.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> performMoveOf: aShip to: targetPosition [

	| shipsPreviousPosition |
	shipsPreviousPosition := self positionOf: aShip.
	board removeShip: aShip fromCellAt: shipsPreviousPosition.
	board addShip: aShip toCellAt: targetPosition.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> playCard: aCard from: aShip to: anotherShip [

	self isShipSupposedToPLay: aShip.
	
	"(self cardManagerOf: anotherShip) addCardsAffecting: aCard."
	
	cardPlayHandler handle: aCard from: aShip to: anotherShip .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> positionOf: aShip [

	^ ((board cells) detect: [ :cell | cell includes: aShip ]) number.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> reducePenaltyFor: aShip [

	| remaining |
	remaining := (penalties at: aShip) - 1.
	remaining > 0 ifTrue: [ penalties at: aShip put: remaining ]
		ifFalse: [ 
			aShip restoreFuel.
			penalties removeKey: aShip ]

]

{ #category : 'initialization' }
SpaceShipGame >> returnToInitialPosition: aShip [

	| stepsDone shipsPreviousPosition targetPosition |
	
	shipsPreviousPosition := self positionOf: aShip.
	targetPosition := 1.
	stepsDone := shipsPreviousPosition - targetPosition.
	self performMoveOf: aShip to: targetPosition.
	self updateLapFor: aShip withTotalSteps: (stepsDone negated). 
	
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> shipsPlaying [

	^ ships
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> skipTurnFor: aShip [

	penalties at: aShip put: (penalties at: aShip ifAbsent: [ 0 ]) + 1.

]

{ #category : 'accessing' }
SpaceShipGame >> start [

	^ 'The Game Has Started'
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> throwDiceFor: aShip [

	| resultOfTheThrow throwModified |
	
	resultOfTheThrow := (dices collect: [ :dice | dice beThrown ]) sum.
	lastDiceThrow := resultOfTheThrow.
	"resultOfMovement:=aShip adjustThrow:resultOfTheThrow."
	throwModified := self modifyThrowFor: aShip.
	
	
	self move: aShip by: resultOfTheThrow + throwModified .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> tryToMoveUsingAllyOf: aShip to: targetPosition consuming: aConsumption [ 
	| ally |
	ally := aShip haveAllianceWith.
	ally currentFuel > aConsumption
		ifTrue: [
			ally consumeFuel: aConsumption.
			self performMoveOf: aShip to: targetPosition
		]
		ifFalse: [
			self penalize: aShip withTurns: 2.
			self penalize: ally withTurns: 2
		].

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> updateLapFor: aShip withTotalSteps: totalSteps [
	
	shipsCurrentLap at: aShip put: (shipsCurrentLap at: aShip) + (totalSteps // board numberOfCells).

]

{ #category : 'accessing' }
SpaceShipGame >> winningLap [

	^ winningLaps
]
