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

{ #category : 'as yet unclassified' }
Deck >> cardsInHand: aShip [ 
	| shipCards |
	shipCards := cardsPerShip at: aShip.
	^ shipCards
]

{ #category : 'as yet unclassified' }
Deck >> giveCardsTo: ships [
	cardsPerShip := Dictionary new.
	ships do: [ :ship | cardsPerShip at: ship put: (self initialCards) ].
	
]

{ #category : 'as yet unclassified' }
Deck >> initialCards [

	| twoInitialCards |
	twoInitialCards:= OrderedCollection with: (cards atRandom) with: (cards atRandom).
	^ twoInitialCards.
]

{ #category : 'initialization' }
Deck >> initializeWith: someCards [

	cards:= someCards .
]
