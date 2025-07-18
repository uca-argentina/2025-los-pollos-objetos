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
AChargedDeck class >> buildWith: aBlockCollection and: times [
	| cards |
	cards := OrderedCollection new.
	times timesRepeat: [
		cards addAll: (aBlockCollection collect: [:cardBlock | cardBlock value]).
	].
	^ cards.

]

{ #category : 'instance creation' }
AChargedDeck class >> cards: aBlockCollection withNShips: times [

	| cards |
	cards := self buildWith: aBlockCollection and: times.
	
	^ self new initializeWith: cards

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
