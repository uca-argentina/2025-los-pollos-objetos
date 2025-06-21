Class {
	#name : 'AllianceCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AllianceCard >> disableCard:aCardPlayHandler [


	aCardPlayHandler resolveAnDisableAllianceCardPlay: self.
]

{ #category : 'testing' }
AllianceCard >> effect [ 
	^ 0
]

{ #category : 'testing' }
AllianceCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnAllianceCardPlay: self
]
