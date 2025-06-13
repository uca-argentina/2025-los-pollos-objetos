Class {
	#name : 'CellGenerator',
	#superclass : 'Object',
	#instVars : [
		'probabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CellGenerator class >> basedOn: someProbabilities [

	^ (self new) initializeProbabilitiesWith: someProbabilities.
]

{ #category : 'initialization' }
CellGenerator >> determineATypeOfCellOn: aCellNumber [

	| pickedCell |
	
   pickedCell := self pickATypeOfCell.

	^ pickedCell
	
]

{ #category : 'initialization' }
CellGenerator >> initializeProbabilitiesWith: someProbabilities [

	probabilities := someProbabilities.
]

{ #category : 'initialization' }
CellGenerator >> pickATypeOfCell [

	| randomValue selectedCell |
	randomValue := ((Random new next) * 100) truncated / 100.0.

	selectedCell := nil.
	probabilities keys asSortedCollection do: [:key |
    	(randomValue <= key and: [selectedCell isNil]) ifTrue: [
        	selectedCell := probabilities at: key
    	].
	].

	^ selectedCell 

	
]
