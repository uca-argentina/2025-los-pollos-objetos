Class {
	#name : 'OverloadCard',
	#superclass : 'Card',
	#instVars : [
		'owner',
		'target'
	],
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
OverloadCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	aGame isShipSupposedToPLay: aCardOwner.
	aGame applyACardEffect: self to: aCardTarget.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
