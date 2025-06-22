Class {
	#name : 'RepeatCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RepeatCard >> uses: aCardPlayHandler [

	aCardPlayHandler resolveARepeatCardPlay: self
]
