Class {
	#name : 'BalckHole',
	#superclass : 'Square',
	#instVars : [
		'firstEntance',
		'secondEntrance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
BalckHole class >> firstEntrance: firstEntrance secondEntrance: secondEntrance [ 
	^ self new initializeWithFirstEntrance: firstEntrance secondEntrance: secondEntrance .
]

{ #category : 'initialization' }
BalckHole >> initializeWithFirstEntrance: aFirstEntrance secondEntrance: aSecondEntrance [ 
	firstEntance:= aFirstEntrance .
	secondEntrance:= aSecondEntrance .
]
