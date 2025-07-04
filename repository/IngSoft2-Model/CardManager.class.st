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

	cardsInHand add:  aCard .
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
CardManager >> deleteCardsAffecting: aCardClass [
    | found |

    found := cardsAffecting anySatisfy: [:each | each class = aCardClass ].

    found ifFalse: [ self error: 'There is no active card about this type' ].

    cardsAffecting removeAllSuchThat: [:each | each class = aCardClass ].

]

{ #category : 'initialization' }
CardManager >> giveInitialCardsFrom: aDeck [

	cardsInHand add: aDeck pickCard.
	cardsInHand add: aDeck pickCard.
]

{ #category : 'initialization' }
CardManager >> hasInHand: aCard [

	^ cardsInHand includes: aCard
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
