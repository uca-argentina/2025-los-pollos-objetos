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
	aCard uses: self.
]

{ #category : 'initialization' }
CardPlayHandler >> handleDisable: aCard from: aShip to: anotherShip [

	cardOwner:= aShip.
	cardTarget:= anotherShip.
	aCard disableCard: self.
]

{ #category : 'initialization' }
CardPlayHandler >> initializeWith: aGame [

	game := aGame.
	lastCardPlayed := Card new.
]

{ #category : 'initialization' }
CardPlayHandler >> resolveAAccelerationCardPlay: aCard [
	
	game isShipSupposedToPLay: cardOwner.
	game applyToAllSpaceShips: aCard.
	lastCardPlayed := aCard.
	
]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveAAllianceCardPlay: aCard [

	game isShipSupposedToPLay: cardOwner.
	game ally: cardOwner with: cardTarget.
	lastCardPlayed := aCard.
	

]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveACancellationCardPlay: aCard and: cancelCard [

	game discardACardEffect: aCard .
	lastCardPlayed := aCard.
	game eliminate: cancelCard from: cardOwner.
]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveADisableAlliance: aCard [
	
		game disableAllianceof: cardOwner with: cardTarget .

]

{ #category : 'initialization' }
CardPlayHandler >> resolveARedoCard: aCard [ 
	
	(lastCardPlayed class = Card)
		ifTrue: [ Error signal: 'Theres no last card play. Invalid ReDo card' ] 
		ifFalse: [ 	
				game addASpecificCard: lastCardPlayed toShip: cardOwner .
				game playCard: lastCardPlayed from: cardOwner to: cardTarget . 
		]


]

{ #category : 'initialization' }
CardPlayHandler >> resolveARepeatedCardPlay: aCard [

	game applyLastEffectTo: cardTarget .
	lastCardPlayed := aCard.
	game eliminate: aCard from: cardOwner.
]

{ #category : 'initialization' }
CardPlayHandler >> resolveAnOverloadCardPlay: aCard [

	game isShipSupposedToPLay: cardOwner.
	game applyACardEffect: aCard to: cardTarget .
	lastCardPlayed := aCard.
	
]
