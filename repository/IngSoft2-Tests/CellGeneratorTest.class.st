Class {
	#name : 'CellGeneratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CellGeneratorTest >> testWhenACellIsDeterminedThenItIsReturnedAndAShipCanEnter [

	| aShip aCellGenerator aCell |
	
	aShip := Ship named: 'The Batwing'.
	aCellGenerator := CellGenerator new.
	
	aCell := aCellGenerator determineATypeOfCellOn: 1.
	aCell enters: aShip.
	
	self assert: (aCell includes: aShip) equals: true.
]

{ #category : 'tests' }
CellGeneratorTest >> testWhenACellIsDeterminedThenItIsReturnedAndAShipCanLeave [

	| aShip aCellGenerator aCell |
	
	aShip := Ship named: 'The Batwing'.
	aCellGenerator := CellGenerator new.
	
	aCell := aCellGenerator determineATypeOfCellOn: 1.
	aCell enters: aShip.
	aCell leaves: aShip.
	
	self deny: (aCell includes: aShip) equals: true.
]

{ #category : 'tests' }
CellGeneratorTest >> testWhenACellIsGeneratedThenItIsReturnedAndAShipCanEnter [

	| aShip aCellGenerator someProbabilites aCell |
	
	aShip := Ship named: 'The Batwing'.
	aCellGenerator := CellGenerator new.
	someProbabilites := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: 1) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: 1 ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: 1 withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: 1 withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: 1 withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: 1) ;
        yourself.
	
	aCell := aCellGenerator pickATypeOfCellFrom: someProbabilites.
	aCell enters: aShip.
	
	self assert: (aCell includes: aShip) equals: true.
]

{ #category : 'tests' }
CellGeneratorTest >> testWhenACellIsGeneratedThenItIsReturnedAndAShipCanLeave [

	| aShip aCellGenerator someProbabilites aCell |
	
	aShip := Ship named: 'The Batwing'.
	aCellGenerator := CellGenerator new.
	someProbabilites := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: 1) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: 1 ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: 1 withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: 1 withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: 1 withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: 1) ;
        yourself.
	
	aCell := aCellGenerator pickATypeOfCellFrom: someProbabilites.
	aCell enters: aShip.
	aCell leaves: aShip.
	
	self deny: (aCell includes: aShip) equals: true.
]
