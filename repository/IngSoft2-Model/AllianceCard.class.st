Class {
	#name : 'AllianceCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AllianceCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAAllianceCardPlay: self
]
