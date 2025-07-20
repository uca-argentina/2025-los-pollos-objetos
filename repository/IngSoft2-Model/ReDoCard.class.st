Class {
	#name : 'ReDoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ReDoCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'testing' }
ReDoCard >> isReversePolarity [

	^ false.
]

{ #category : 'testing' }
ReDoCard >> transitionState [
	
	^ self.
]

{ #category : 'testing' }
ReDoCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	| lastCardPlayed |
	
	lastCardPlayed := self wasACardPreviouslyPlayedIn: aGame.
	aGame addASpecificCard: lastCardPlayed toShip: aCardOwner.
	aGame playCard: lastCardPlayed from: aCardOwner to: aCardTarget.
	aGame eliminate: self from: aCardOwner.
]

{ #category : 'testing' }
ReDoCard >> wasACardPreviouslyPlayedIn: aGame [

	| lastCardPlayed |
	lastCardPlayed := aGame lastPlayedCard.
	(lastCardPlayed class = Card)
		ifTrue: [ Error signal: 'Theres no last card play. Invalid ReDo card' ] 
		ifFalse: [ ^ lastCardPlayed ].
]
