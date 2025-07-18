Class {
	#name : 'CancellationCard',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
CancellationCard >> cancellationWhenCardToCancelIsAAllianceCardOf: aGame [

	cardToCancel disableAllianceIn: aGame.
]

{ #category : 'as yet unclassified' }
CancellationCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'as yet unclassified' }
CancellationCard >> selectedCard: aCard [

	cardToCancel := aCard.
]

{ #category : 'testing' }
CancellationCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	self cancellationWhenCardToCancelIsAAllianceCardOf: aGame.
	aGame discardACardEffect: cardToCancel.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
