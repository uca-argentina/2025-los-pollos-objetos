Class {
	#name : 'OverloadCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
OverloadCard >> effect [

	^ -2.
]

{ #category : 'as yet unclassified' }
OverloadCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnOverloadCardPlay: self
]
