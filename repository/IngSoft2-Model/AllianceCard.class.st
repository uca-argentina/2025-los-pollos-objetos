Class {
	#name : 'AllianceCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AllianceCard >> disableCard:aCardPlayHandler [

	aCardPlayHandler resolveADisableAlliance: self.
]

{ #category : 'testing' }
AllianceCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAAllianceCardPlay: self
]
