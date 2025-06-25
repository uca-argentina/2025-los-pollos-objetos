Class {
	#name : 'ReDoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ReDoCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveARedoCard: self.
]
