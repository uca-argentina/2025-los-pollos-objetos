Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AccelerationCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'testing' }
AccelerationCard >> effect [

	^ 1
]

{ #category : 'testing' }
AccelerationCard >> isReversePolarity [

	^ false.
]

{ #category : 'testing' }
AccelerationCard >> transitionState [
	
	^ self.
]

{ #category : 'testing' }
AccelerationCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	aGame isShipSupposedToPlay: aCardOwner.
	aGame applyToAllSpaceShips: self.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
