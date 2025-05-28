Class {
	#name : 'ChargedBoardWithOneMoonWalkCell',
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
ChargedBoardWithOneMoonWalkCell class >> isAPositiveInteger: aNumber [

    (aNumber isInteger and: [ aNumber > 0 ]) ifFalse: [
        Error signal: 'Number of cells must be a positive integer.' ].
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneMoonWalkCell class >> the: firstEntrance isDifferentFrom: secondEntrance [

    (firstEntrance = secondEntrance) ifTrue: [
        Error signal:
            'The entrances of the Black Hole must be in different cells.' ]
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneMoonWalkCell class >> the: secondEntrance isSmallerThan: firstEntrance [

    (firstEntrance > secondEntrance) ifTrue: [
        Error signal:
            'The First Entrance of Black Hole must come before the Second Entrance.' ]
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneMoonWalkCell class >> theCell: position isOutOfRange: range [

    ( position > range ) ifTrue: [
        Error signal: 'The cells of the Black Hole must in the board.' ].
]

{ #category : 'as yet unclassified' }
ChargedBoardWithOneMoonWalkCell class >> withATotalNumberOfCellsOf: numberOfCells andAWormHoleBetweenCells: firstEntrance and: secondEntrance andAMoonWalkCell: aMoonWalkCell onCell: aNumberOfCell [
 
    self isAPositiveInteger: numberOfCells.
    self isAPositiveInteger: firstEntrance.
    self isAPositiveInteger: secondEntrance.

    self theCell: firstEntrance isOutOfRange: numberOfCells.
    self theCell: secondEntrance isOutOfRange: numberOfCells.

    self the: firstEntrance isDifferentFrom: secondEntrance.
    self the: secondEntrance isSmallerThan: firstEntrance.

    ^ self new  initializeWith: numberOfCells andAWormHoleBeweenCells: firstEntrance and: secondEntrance andAMoonWalkCell: aMoonWalkCell onCell: aNumberOfCell

]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> addShip: aShip toCellAt: aPosition [
    
    (cells at: aPosition) enters: aShip.

]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> cellNumber: aNumber [
	
    ^ cells at: aNumber


]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> changeCellAt: aPosition to: aCell [

	cells at: aPosition put: aCell. 



]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> checkCell: aShip of: aGame [

	(cells at: aShip position) applyEffectTo: aShip of: aGame. 
]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> getShipsIntoFirstCellOfTheBoard: shipsCollection [

    | startCell |

    startCell := cells first.
    shipsCollection do: [ :aShip | startCell enters: aShip ].


]

{ #category : 'initialization' }
ChargedBoardWithOneMoonWalkCell >> initializeWith: numberOfCells andAWormHoleBeweenCells: firstEntrance and: secondEntrance andAMoonWalkCell: aMoonWalkCell onCell: aNumberOfCell [

	 cells := OrderedCollection new.
    1 to: (numberOfCells) do: [:i | cells add: (NormalCell initializeCellOn: i) ].
	 cells at:aNumberOfCell put: (aMoonWalkCell ).
    wormsHolesFirstEntrance := firstEntrance.
    wormsHolesSecondEntrance := secondEntrance.
]

{ #category : 'initialization' }
ChargedBoardWithOneMoonWalkCell >> numberOfCells [

	^ cells size.
]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> removeShip: aShip fromCellAt: aPosition [
    
    (cells at: aPosition) leaves: aShip.

]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> wormsHolesFirstEntrance [

    ^ wormsHolesFirstEntrance.
]

{ #category : 'accessing' }
ChargedBoardWithOneMoonWalkCell >> wormsHolesSecondEntrance [

    ^ wormsHolesSecondEntrance.
]
