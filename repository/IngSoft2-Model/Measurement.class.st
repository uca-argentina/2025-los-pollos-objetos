Class {
	#name : 'Measurement',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Measurement class >> with: aValue [

	^ self new initializeWith: aValue
]

{ #category : 'initialization' }
Measurement >> initializeWith: aValue [

	value:=aValue.
]

{ #category : 'initialization' }
Measurement >> valueInParsecs [

	self subclassResponsibility 
]
