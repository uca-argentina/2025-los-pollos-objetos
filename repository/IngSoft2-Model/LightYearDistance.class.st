Class {
	#name : 'LightYearDistance',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
LightYearDistance class >> with: aValue [

	^ self new initializeWith: aValue
]

{ #category : 'initialization' }
LightYearDistance >> initializeWith: aValue [

	value:=aValue.
]

{ #category : 'initialization' }
LightYearDistance >> valueInParsecs [

	^ value //3.
]
