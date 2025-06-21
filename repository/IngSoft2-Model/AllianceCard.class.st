Class {
	#name : 'AllianceCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AllianceCard >> effect [ 
	^ 0
]

{ #category : 'testing' }
AllianceCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveAnAllianceCardPlay: self
]
