Class {
	#name : 'CardPlayHandler',
	#superclass : 'Object',
	#instVars : [
		'game',
		'cardOwner',
		'cardTarget',
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardPlayHandler class >> with: aGame [

	^ self new initializeWith: aGame
]

{ #category : 'initialization' }
CardPlayHandler >> handle: aCard from: aShip to: anotherShip [


	cardOwner:= aShip.
	cardTarget:= anotherShip.
	aCard uses: self
]

{ #category : 'initialization' }
CardPlayHandler >> handleDisable: aCard from: aShip to: anotherShip [


	cardOwner:= aShip.
	cardTarget:= anotherShip.
	aCard disableCard: self
]

{ #category : 'initialization' }
CardPlayHandler >> initializeWith: aGame [

	game:= aGame.
	lastCardPlayed := nil.
]

{ #category : 'initialization' }
CardPlayHandler >> resolveARepeatCardPlay: aCard [

	game applyLastEffectTo: cardTarget .
	lastCardPlayed := aCard.
	game eliminate: aCard from: cardOwner.
]

{ #category : 'initialization' }
CardPlayHandler >> resolveAnAccelerationCardPlay: aCard [
	
	game isShipSupposedToPLay: cardOwner.
	game applyToAllSpaceShips: aCard.
	lastCardPlayed := aCard.
	
]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveAnAllianceCardPlay: aCard [

	game isShipSupposedToPLay: cardOwner.
	game allianceBewtween: cardOwner and: cardTarget.
	lastCardPlayed := aCard.
	

]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveAnCancelationCardPlay: aCard and: cancelCard [
	game discardACardEffect: aCard .
	lastCardPlayed := aCard.
	game eliminate: cancelCard from: cardOwner.
]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveAnDisableAlliance: aCard [
	
		game disableAllianceof: cardOwner with: cardTarget .

]

{ #category : 'initialization' }
CardPlayHandler >> resolveAnOverloadCardPlay: aCard [

	game isShipSupposedToPLay: cardOwner.
	game applyACardEffect: aCard to: cardTarget .
	lastCardPlayed := aCard.
	
]

{ #category : 'initialization' }
CardPlayHandler >> resolveAnRedoCard:aCard [ 
	
	lastCardPlayed isNil 
		ifTrue: [ Error signal: 'Theres no last card play. Invalid ReDo card' ] 
		ifFalse: [ 	
				game addAnEspecificCard: lastCardPlayed toShip: cardOwner .
				game playCard: lastCardPlayed from: cardOwner to: cardTarget . 
				
		]


]
