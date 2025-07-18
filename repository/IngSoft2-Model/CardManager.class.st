Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'cardsInHand',
		'cardsAffecting'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardManager class >> of: aShip with: aDeck [

	^ self new initializeOf: aShip with:aDeck.
	
]

{ #category : 'adding' }
CardManager >> addASpecificCard: aCard [

	cardsInHand add: aCard .
]

{ #category : 'initialization' }
CardManager >> addCardsAffecting: aCard [

	cardsAffecting add: aCard.
]

{ #category : 'initialization' }
CardManager >> applyEffect [

	| effectValue |
	
	effectValue := 0.
	cardsAffecting do: [ :card | effectValue := effectValue + (card effect) ].
	
	^ effectValue.
	
]

{ #category : 'initialization' }
CardManager >> cardsInHand [

	^ cardsInHand 
]

{ #category : 'adding' }
CardManager >> deleteASpecificCard: aCard [

	cardsInHand remove: aCard .
]

{ #category : 'initialization' }
CardManager >> deleteCardsAffecting: aCard [

	| cardToRemove |
	cardToRemove := cardsAffecting detect: [:each | each == aCard ] ifNone: [ ^self ].
	cardsAffecting remove: cardToRemove.

]

{ #category : 'initialization' }
CardManager >> giveInitialCardsFrom: aDeck [

	self pickACard: aDeck.
	self pickACard: aDeck.
]

{ #category : 'initialization' }
CardManager >> hasInHand: aCard [

	^ cardsInHand includes: aCard.
]

{ #category : 'initialization' }
CardManager >> initializeOf: aShip with: aDeck [

	ship:= aShip.
	cardsInHand:= OrderedCollection new.
	cardsAffecting:= OrderedCollection new. 
	self giveInitialCardsFrom: aDeck.
]

{ #category : 'as yet unclassified' }
CardManager >> pickACard: aDeck [

	cardsInHand add: (aDeck pickCard).
]

{ #category : 'initialization' }
CardManager >> ship [

	^ ship 
]
