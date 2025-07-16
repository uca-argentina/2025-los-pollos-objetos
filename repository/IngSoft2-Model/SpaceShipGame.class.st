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
		'cardPlayHandler',
		'lastEffectApplied',
		'allies',
		'maximumPossibleThrow'
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

{ #category : 'adding' }
SpaceShipGame >> addASpecificCard: aCard toShip: aShip [

	| targetCardManager |
	targetCardManager  := cardManagers detect: [ :aCardManager | aCardManager ship = aShip ]
		ifNone: [ self error: 'No CardManager found for the given ship.' ].
	targetCardManager addASpecificCard: aCard.

	
	

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
SpaceShipGame >> alliesOf: aShip [

	^ (allies select: [:pair | pair includes: aShip ])
		collect: [:pair | pair detect: [:ship | ship ~= aShip ]].

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> ally: cardOwner with: cardTarget [
	
	"(allies at: cardOwner) add: cardTarget.
	(allies at: cardTarget) add: cardOwner. "
	allies add: (Set with: cardOwner with: cardTarget).
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> applyACardEffect: aCard to: aShip [

	(self cardManagerOf: aShip ) addCardsAffecting: aCard. 
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> applyLastEffectTo: aShip [

	lastEffectApplied applyEffectTo: aShip of: self.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> applyToAllSpaceShips: aCard [

	cardManagers do: [ :cardManager | cardManager addCardsAffecting: aCard ].
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
SpaceShipGame >> check: aShip has: aCard [

	| cardManager |
	cardManager := self cardManagerOf: aShip .
	(cardManager hasInHand: aCard) ifFalse: [
		Error signal:
			'Ship cannot throw this card because it does not have this' ]
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> currentLapFor: aShip [

	^ shipsCurrentLap at: aShip.
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> determineTheConsequencesOfTheThrowIn: aNewPosition forShip: aShip [
		
	| aShipCurrentLap |
	
	(lastDiceThrow = maximumPossibleThrow ) ifTrue: [ self rewardForMaximumThrowTo: aShip ].

	aShipCurrentLap := self currentLapFor: aShip.
	(aShipCurrentLap = winningLaps ) ifTrue: [ ^ aShip name , ' won the Game!' ].
	
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> disableAllianceOf: aShip with: anotherShip [
	
	allies remove: (Set with: aShip with: anotherShip).
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> discardACardEffect: aCard [
	
	cardManagers do: [ :aCardManager | aCardManager deleteCardsAffecting: aCard ].
 
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> eliminate: aCard from: aShip [

	| cardManagerShip |

	cardManagerShip := self cardManagerOf: aShip.

	cardManagerShip deleteASpecificCard: aCard.

]

{ #category : 'as yet unclassified' }
SpaceShipGame >> executeTurn [

	| ship |
	
	ship := self advanceTurnIfCurrentTurnsShipIsPenalized.
	ship := ships at: shipSupposedToPlay.

	self throwDiceFor: ship.
	lastEffectApplied := board determineAndApplyEffectTo: ship atCurrentCellFrom: self.
	self advanceTurn.

	^ ship
]

{ #category : 'initialization' }
SpaceShipGame >> initializeWith: laps with: aBoard with: gameDices with: gameShips with: aDeck [

	winningLaps := laps.

	dices := gameDices.
	maximumPossibleThrow := dices inject: 0 into: [:sum :dice | sum + dice sizeOfTheDice].
	
	deck:= aDeck.
	cardManagers := gameShips collect: [ :aShip | CardManager of: aShip with: aDeck ].
	cardPlayHandler:= CardPlayHandler with: self.
	
	ships := gameShips.
	
   board := aBoard.
	board getShipsIntoFirstCellOfTheBoard: gameShips.
	
	shipSupposedToPlay := 1.
	penalties := Dictionary new.
	
	shipsCurrentLap := Dictionary new.
	ships do: [ :ship | shipsCurrentLap at: ship put: 0 ].
	
	allies := Set new.
	"ships do: [ :ship | allies at: ship put: OrderedCollection new.]."

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
	(aShip currentFuel > aConsumption)
	ifTrue: [
		self move: aShip to: targetPosition andConsume: aConsumption ]
	ifFalse: [
		self tryToMoveUsingAllyOf: aShip to: targetPosition consuming: aConsumption ].
	self updateLapFor: aShip withTotalSteps: totalSteps.
]

{ #category : 'accessing' }
SpaceShipGame >> move: aShip to: targetPosition andConsume: aConsumption [

	aShip consumeFuel: aConsumption.
	self performMoveOf: aShip to: targetPosition.

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

{ #category : 'accessing' }
SpaceShipGame >> pickACardFor: aShip [
	| targetCardManager |
	targetCardManager  := cardManagers detect: [ :aCardManager | aCardManager ship = aShip ]
		ifNone: [ self error: 'No CardManager found for the given ship.' ].
	targetCardManager pickACard: deck .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> playCard: aCard from: aShip to: anotherShip [

	self check: aShip has: aCard.
	
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
SpaceShipGame >> rewardForMaximumThrowTo: aShip [

	| result |
	result := (Random new next < 0.8) ifTrue: [ aShip receiveReward ] ifFalse: [ aShip consumeFuel: 1 ].
]

{ #category : 'adding' }
SpaceShipGame >> shipCardsInHand: aShip [
	| targetCardManager |
	
	targetCardManager := self cardManagerOf: aShip.
	
	^ targetCardManager cardsInHand size.

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
	
	throwModified := self modifyThrowFor: aShip.
	
	self move: aShip by: resultOfTheThrow + throwModified .
]

{ #category : 'as yet unclassified' }
SpaceShipGame >> tryToMoveUsingAllyOf: aShip to: targetPosition consuming: aConsumption [

	| aShipAllies usableAllies allyToUse|
	aShipAllies := self alliesOf: aShip.
	usableAllies := aShipAllies select: [ :ally | ally currentFuel > aConsumption ].

	usableAllies isEmpty
		ifTrue: [
			self penalize: aShip withTurns: 2.
			aShipAllies do: [ :ally | self penalize: ally withTurns: 2 ]
		]
		ifFalse: [
			allyToUse := usableAllies anyOne.
			allyToUse consumeFuel: aConsumption.
			self performMoveOf: aShip to: targetPosition
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
