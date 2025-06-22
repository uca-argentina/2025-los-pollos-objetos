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
AChargedDeck class >> cards: aBlockCollection withNShips: times [ 
	| cards |
	cards := OrderedCollection new.
	times timesRepeat: [
		aBlockCollection do: [:cardBlock |
			cards add: cardBlock value.
		].
	].
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
