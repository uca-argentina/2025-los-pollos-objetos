Class {
	#name : 'OverloadCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
OverloadCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'as yet unclassified' }
OverloadCard >> effect [

	^ -2.
]

{ #category : 'as yet unclassified' }
OverloadCard >> isReversePolarity [

	^ false.
]

{ #category : 'as yet unclassified' }
OverloadCard >> transitionState [
	
	^ self.
]

{ #category : 'as yet unclassified' }
OverloadCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	aGame isShipSupposedToPlay: aCardOwner.
	aGame addACardEffect: self to: aCardTarget.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
