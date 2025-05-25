Class {
	#name : 'NormalCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
NormalCellTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
NormalCellTest >> testWhenANormalCellIsInitializedThenItHasANumber [

	| aNormalCell |
	aNormalCell := NormalCell initializeCellOn: 1.
	
	self assert: (aNormalCell number) equals: 1. 
]

{ #category : 'tests' }
NormalCellTest >> testWhenANormalCellIsInitializedWithANegativeNumberThenCreationFails [

	 self
        should: [NormalCell initializeCellOn: -1]
        raise: Error
        withMessageText: 'Number of cell must be a positive integer.'.
]

{ #category : 'tests' }
NormalCellTest >> testWhenAShipEntersACellThenIsEffectivelyInThere [

	| aShip aNormalCell |
	aShip := Ship named: 'Millenium Falcon'.
	aNormalCell := NormalCell initializeCellOn: 1.
	
	aNormalCell enters: aShip.
	
	self assert: (aNormalCell includes: aShip).  
]

{ #category : 'tests' }
NormalCellTest >> testWhenAShipExitsANormalCellThenIsEffectivelyOutThere [

	| aShip aNormalCell |
	aShip := Ship named: 'Millenium Falcon'.
	aNormalCell := NormalCell initializeCellOn: 1.
	
	aNormalCell enters: aShip.
	aNormalCell leaves: aShip.
	
	self deny: (aNormalCell includes: aShip). 
]
