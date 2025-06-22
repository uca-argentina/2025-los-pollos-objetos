Class {
	#name : 'ParsecDistance',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ParsecDistance class >> with: aValue [

	^ self new initializeWith: aValue
]

{ #category : 'initialization' }
ParsecDistance >> initializeWith: aValue [

	value:= aValue.
]

{ #category : 'initialization' }
ParsecDistance >> valueInParsecs [
	^ value
]
