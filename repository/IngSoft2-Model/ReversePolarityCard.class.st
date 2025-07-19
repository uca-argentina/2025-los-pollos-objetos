Class {
	#name : 'ReversePolarityCard',
	#superclass : 'Card',
	#instVars : [
		'cell',
		'game',
		'cardOwner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ReversePolarityCard >> cellNumberAffected [

	^ cell number.
]

{ #category : 'testing' }
ReversePolarityCard >> disableAllianceIn: aGame [
	
	^ self.
]

{ #category : 'testing' }
ReversePolarityCard >> effect [ 

	^ 0.
]

{ #category : 'testing' }
ReversePolarityCard >> selectedCell: aNumberOfCell of: aGame [

	cell := aGame cellAt: aNumberOfCell.
]

{ #category : 'testing' }
ReversePolarityCard >> useFrom: aCardOwner to: aCardTarget in: aGame [

	aGame isShipSupposedToPLay: aCardOwner.
	aGame addACardEffect: self to: aCardOwner.
	aGame eliminate: self from: aCardOwner.
	aGame lastPlayedCardWas: self.
]
