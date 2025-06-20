Class {
	#name : 'Deck',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'cardsPerShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Deck class >> with: someCards [

	^ self new initializeWith: someCards.
]

{ #category : 'initialization' }
Deck >> initializeWith: someCards [

	cards:= someCards .
]

{ #category : 'initialization' }
Deck >> pickCard [

	^ cards atRandom 

]
