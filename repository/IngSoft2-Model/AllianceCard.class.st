Class {
	#name : 'AllianceCard',
	#superclass : 'Card',
	#instVars : [
		'owner',
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AllianceCard >> disableAllianceIn: aGame [
	
	aGame disableAllianceBetween: owner and: target.
	
	 
]

{ #category : 'testing' }
AllianceCard >> isReversePolarity [

	^ false.
]

{ #category : 'testing' }
AllianceCard >> remember: aCardOwner and: aCardTarget [

	owner := aCardOwner.
	target := aCardTarget.
]

{ #category : 'testing' }
AllianceCard >> transitionState [
	
	^ self.
	
	 
]

{ #category : 'testing' }
AllianceCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	aGame isShipSupposedToPlay: aCardOwner.
	aGame ally: aCardOwner with: aCardTarget.
	self remember: aCardOwner and: aCardTarget.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
