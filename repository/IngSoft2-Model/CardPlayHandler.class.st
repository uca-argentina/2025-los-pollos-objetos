Class {
	#name : 'CardPlayHandler',
	#superclass : 'Object',
	#instVars : [
		'game',
		'cardOwner',
		'cardTarget'
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
CardPlayHandler >> initializeWith: aGame [

	game:= aGame
]

{ #category : 'initialization' }
CardPlayHandler >> resolveAnAccelerationCardPlay: aCard [

	game applyToAllSpaceShips: aCard.
]

{ #category : 'as yet unclassified' }
CardPlayHandler >> resolveAnAllianceCardPlay: aCard [

	game allianceBewtween: cardOwner and: cardTarget.

	game applyACardEffect: aCard to: cardTarget .
]

{ #category : 'initialization' }
CardPlayHandler >> resolveAnOverloadCardPlay: aCard [

	game applyACardEffect: aCard to: cardTarget .
]
