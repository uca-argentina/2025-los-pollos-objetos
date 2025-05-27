Class {
	#name : 'ChargedBoardWithOneBlackHoleCell',
	#superclass : 'Object',
	#instVars : [
		'numberOfCells',
		'totalBoardCells',
		'cells',
		'wormsHolesFirstEntrance',
		'wormsHolesSecondEntrance'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
ChargedBoardWithOneBlackHoleCell class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber > 0 ]) ifFalse: [
        Error signal: 'Number of cells must be a positive integer.' ].
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneBlackHoleCell class >> the: firstEntrance isDifferentFrom: secondEntrance [

    (firstEntrance = secondEntrance) ifTrue: [
        Error signal:
            'The entrances of the Black Hole must be in different cells.' ]
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneBlackHoleCell class >> the: secondEntrance isSmallerThan: firstEntrance [

    (firstEntrance > secondEntrance) ifTrue: [
        Error signal:
            'The First Entrance of Black Hole must come before the Second Entrance.' ]
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneBlackHoleCell class >> theCell: position isOutOfRange: range [

    ( position > range ) ifTrue: [
        Error signal: 'The cells of the Black Hole must in the board.' ].
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneBlackHoleCell class >> withATotalNumberOfCellsOf: numberOfCells andAWormHoleBetweenCells: firstEntrance and: secondEntrance andAnBlackHoleOnCell: aNumberOfCell [
 
    self isAPositiveInteger: numberOfCells.
    self isAPositiveInteger: firstEntrance.
    self isAPositiveInteger: secondEntrance.

    self theCell: firstEntrance isOutOfRange: numberOfCells.
    self theCell: secondEntrance isOutOfRange: numberOfCells.

    self the: firstEntrance isDifferentFrom: secondEntrance.
    self the: secondEntrance isSmallerThan: firstEntrance.

    ^ self new  initializeWith: numberOfCells andAWormHoleBeweenCells: firstEntrance and: secondEntrance andAnBlackHoleOnCell: aNumberOfCell

]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> addShip: aShip toCellAt: aPosition [
    
    (cells at: aPosition) enters: aShip.

]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> cellNumber: aNumber [
	
    ^ cells at: aNumber


]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> changeCellAt: aPosition to: aCell [

	cells at: aPosition put: aCell. 



]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> checkCell: aShip of: aGame [

	(cells at: aShip position) applyEffectTo: aShip of: aGame. 
]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> getShipsIntoFirstCellOfTheBoard: shipsCollection [

    | startCell |

    startCell := cells first.
    shipsCollection do: [ :aShip | startCell enters: aShip ].


]

{ #category : 'initialization' }
ChargedBoardWithOneBlackHoleCell >> initializeWith: numberOfCells andAWormHoleBeweenCells: firstEntrance and: secondEntrance andAnBlackHoleOnCell: aNumberOfCell [

	 cells := OrderedCollection new.
    1 to: (numberOfCells) do: [:i | cells add: (NormalCell initializeCellOn: i) ].
	 cells at:aNumberOfCell put: (BlackHoleCell initializeCellOn: aNumberOfCell).
    wormsHolesFirstEntrance := firstEntrance.
    wormsHolesSecondEntrance := secondEntrance.
]

{ #category : 'initialization' }
ChargedBoardWithOneBlackHoleCell >> numberOfCells [

	^ cells size.
]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> removeShip: aShip fromCellAt: aPosition [
    
    (cells at: aPosition) leaves: aShip.

]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> wormsHolesFirstEntrance [

    ^ wormsHolesFirstEntrance.
]

{ #category : 'accessing' }
ChargedBoardWithOneBlackHoleCell >> wormsHolesSecondEntrance [

    ^ wormsHolesSecondEntrance.
]
