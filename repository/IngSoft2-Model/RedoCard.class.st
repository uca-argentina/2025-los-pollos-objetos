Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RedoCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnRedoCard: self.
]
