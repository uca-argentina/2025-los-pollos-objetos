Class {
	#name : 'AChargedDeck',
	#superclass : 'Object',
	#instVars : [
		'numberOfFacesOfTheDice',
		'cards'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
AChargedDeck class >> with: aCollection [ 
	^ self new initializeWith: aCollection 
]

{ #category : 'accessing' }
AChargedDeck >> cards [
^ cards 
]

{ #category : 'initialization' }
AChargedDeck >> initializeWith: someCards [

	cards:= someCards .
]

{ #category : 'initialization' }
AChargedDeck >> pickCard [

	| cardToPick |
	cards isEmpty ifTrue: [ Error signal: 'No cards to pick' ].
	cardToPick := cards first.
	cards remove: cardToPick.
	^ cardToPick


]
