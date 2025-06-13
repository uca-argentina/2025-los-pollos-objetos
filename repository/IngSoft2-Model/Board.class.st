Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numberOfCells',
		'totalBoardCells',
		'cells',
		'wormsHolesFirstEntrance',
		'wormsHolesSecondEntrance',
		'aCellGenerator',
		'someProbabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber > 0 ]) ifFalse: [
        Error signal: 'Number of cells must be a positive integer.' ].
]

{ #category : 'as yet unclassified' }
Board class >> the: firstEntrance isDifferentFrom: secondEntrance [

    (firstEntrance = secondEntrance) ifTrue: [
        Error signal:
            'The entrances of the Black Hole must be in different cells.' ]
]

{ #category : 'as yet unclassified' }
Board class >> the: secondEntrance isSmallerThan: firstEntrance [

    (firstEntrance > secondEntrance) ifTrue: [
        Error signal:
            'The First Entrance of Black Hole must come before the Second Entrance.' ]
]

{ #category : 'as yet unclassified' }
Board class >> theCell: position isOutOfRange: range [

    ( position > range ) ifTrue: [
        Error signal: 'The cells of the Black Hole must in the board.' ].
]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: numberOfCells andAWormHoleBetweenCells: firstEntrance and: secondEntrance [
 
    self isAPositiveInteger: numberOfCells.
    self isAPositiveInteger: firstEntrance.
    self isAPositiveInteger: secondEntrance.

    self theCell: firstEntrance isOutOfRange: numberOfCells.
    self theCell: secondEntrance isOutOfRange: numberOfCells.

    self the: firstEntrance isDifferentFrom: secondEntrance.
    self the: secondEntrance isSmallerThan: firstEntrance.

    ^ self new  initializeWith: numberOfCells
        andAWormHoleBeweenCells: firstEntrance 
        and: secondEntrance.

]

{ #category : 'accessing' }
Board >> addShip: aShip toCellAt: aPosition [
    
    (cells at: aPosition) enters: aShip.

]

{ #category : 'accessing' }
Board >> cellNumber: aNumber [
	
    ^ cells at: aNumber


]

{ #category : 'accessing' }
Board >> checkCell: aShip of: aGame [

	(cells at: aShip position) applyEffectTo: aShip of: aGame. 
]

{ #category : 'accessing' }
Board >> getShipsIntoFirstCellOfTheBoard: shipsCollection [

    | startCell |

    startCell := cells first.
    shipsCollection do: [ :aShip | startCell enters: aShip ].


]

{ #category : 'initialization' }
Board >> initializeWith: numberOfCells andAWormHoleBeweenCells: firstEntrance and: secondEntrance [

	cells := OrderedCollection new.
	someProbabilities := Dictionary new
        at: 0.4 put: (NormalCell initializeCellOn: numberOfCells) ;
        at: 0.6 put: (BlackHoleCell initializeCellOn: numberOfCells ) ;
        at: 0.8 put: (HyperGravityCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.9 put: (MoonWalkCell initializeCellOn: numberOfCells withRequiredValue: 4);
        at: 0.98 put: (HyperJumpCell initializeCellOn: numberOfCells withParsecValues: #(25 10 5) boardLength: 100 numberOfCells: 100) ;
        at: 1 put: (AtomicBombCell initializeCellOn: numberOfCells) ;
        yourself.
	aCellGenerator := CellGenerator basedOn: someProbabilities.
	
	1 to: numberOfCells do: [ :i | cells add: (aCellGenerator determineATypeOfCellOn: i) ].

	wormsHolesFirstEntrance := firstEntrance.
	wormsHolesSecondEntrance := secondEntrance
]

{ #category : 'initialization' }
Board >> numberOfCells [

	^ cells size.
]

{ #category : 'accessing' }
Board >> removeShip: aShip fromCellAt: aPosition [
    
    (cells at: aPosition) leaves: aShip.

]

{ #category : 'accessing' }
Board >> wormsHolesFirstEntrance [

    ^ wormsHolesFirstEntrance.
]

{ #category : 'accessing' }
Board >> wormsHolesSecondEntrance [

    ^ wormsHolesSecondEntrance.
]
