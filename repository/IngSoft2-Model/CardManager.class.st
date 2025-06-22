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
CardManager >> addAnEspecificCard: aCard [
	cardsInHand add:  aCard .
]

{ #category : 'initialization' }
CardManager >> addCardsAffecting: aCard [

	cardsAffecting add: aCard.
]

{ #category : 'initialization' }
CardManager >> applyEffect [

	| effectValue |
	effectValue:=0.
	cardsAffecting do: [ :card | effectValue:= effectValue  + (card effect) ].
	^ effectValue
	
]

{ #category : 'initialization' }
CardManager >> cardsInHand [

	^ cardsInHand 
]

{ #category : 'adding' }
CardManager >> deleteAnEspecificCard: aCard [
	cardsInHand remove:  aCard .
]

{ #category : 'initialization' }
CardManager >> deleteCardsAffecting: aCardClass [
    | found |
    found := cardsAffecting anySatisfy: [:each | each class = aCardClass ].

    found
        ifFalse: [ self error: 'No hay ninguna carta activa de ese tipo.' ].

    cardsAffecting removeAllSuchThat: [:each | each class = aCardClass ].

]

{ #category : 'initialization' }
CardManager >> giveInitialCardsFrom: aDeck [

	cardsInHand add: aDeck pickCard.
	cardsInHand add: aDeck pickCard.
]

{ #category : 'initialization' }
CardManager >> initializeOf: aShip with:aDeck [

	ship:= aShip.
	cardsInHand:= OrderedCollection new.
	cardsAffecting:= OrderedCollection new. 
	self giveInitialCardsFrom: aDeck.
]

{ #category : 'initialization' }
CardManager >> ship [

	^ ship 
]
