Class {
	#name : 'CancellationCard',
	#superclass : 'Object',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
CancellationCard >> effect [ 
	^ 0
]

{ #category : 'as yet unclassified' }
CancellationCard >> selectedCard: aCard [
	cardToCancel := aCard 
]

{ #category : 'testing' }
CancellationCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnCancelationCardPlay: cardToCancel
]
