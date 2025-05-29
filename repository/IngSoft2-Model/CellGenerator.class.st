Class {
	#name : 'CellGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CellGenerator >> determineATypeOfCellOn: aCellNumber [

	| cellsProbabilities pickedCell |
	
	cellsProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: aCellNumber) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: aCellNumber ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: aCellNumber withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: aCellNumber withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: aCellNumber withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: aCellNumber) ;
        yourself.
	
   pickedCell := self pickATypeOfCellFrom: cellsProbabilities .

	^ pickedCell
	
]

{ #category : 'initialization' }
CellGenerator >> pickATypeOfCellFrom: aCellsProbabilities [

	| randomValue selectedCell |
	randomValue := ((Random new next) * 100) truncated / 100.0.

	selectedCell := nil.
	aCellsProbabilities keys asSortedCollection do: [:key |
    	(randomValue <= key and: [selectedCell isNil]) ifTrue: [
        	selectedCell := aCellsProbabilities at: key
    	].
	].

	^ selectedCell 

	
]
