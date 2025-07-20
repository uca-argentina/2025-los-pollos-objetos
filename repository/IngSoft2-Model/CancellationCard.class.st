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

{ #category : 'testing' }
CancellationCard >> cancellationWhenCardToCancelIsAReversedPolarityCard [

	cardToCancel transitionState.
]

{ #category : 'as yet unclassified' }
CancellationCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'as yet unclassified' }
CancellationCard >> isReversePolarity [

	^ false.
]

{ #category : 'as yet unclassified' }
CancellationCard >> selectedCard: aCard [

	cardToCancel := aCard.
]

{ #category : 'as yet unclassified' }
CancellationCard >> transitionState [
	
	^ self.
]

{ #category : 'testing' }
CancellationCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	self cancellationWhenCardToCancelIsAAllianceCardOf: aGame.
	self cancellationWhenCardToCancelIsAReversedPolarityCard.
	aGame discardACardEffect: cardToCancel.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
