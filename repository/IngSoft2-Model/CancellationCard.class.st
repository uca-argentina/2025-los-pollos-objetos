Class {
	#name : 'CancellationCard',
	#superclass : 'Card',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancellationCard >> selectedCard: aCard [
	cardToCancel := aCard 
]

{ #category : 'testing' }
CancellationCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnCancelationCardPlay: cardToCancel
]
