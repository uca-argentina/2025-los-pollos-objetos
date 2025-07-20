Class {
	#name : 'RepeatCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RepeatCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'testing' }
RepeatCard >> transitionState [
	
	^ self.
]

{ #category : 'testing' }
RepeatCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	aGame applyLastEffectTo: aCardTarget.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
