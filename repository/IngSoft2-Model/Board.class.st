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
Board class >> withATotalNumberOfCellsOf: numberOfCells generatedWith: aCellGenerator andAWormHoleBetweenCells: firstEntrance and: secondEntrance [
 
	| boardCells |
	 self isAPositiveInteger: numberOfCells.
    self isAPositiveInteger: firstEntrance.
    self isAPositiveInteger: secondEntrance.

    self theCell: firstEntrance isOutOfRange: numberOfCells.
    self theCell: secondEntrance isOutOfRange: numberOfCells.

    self the: firstEntrance isDifferentFrom: secondEntrance.
    self the: secondEntrance isSmallerThan: firstEntrance.

	boardCells := OrderedCollection new.
	"1 to: numberOfCells do: [ :i | boardCells add: (aCellGenerator determineATypeOfCellOn: i) ]."
	1 to: (firstEntrance - 1) do: [ :i | boardCells add: (aCellGenerator determineATypeOfCellOn: i) ].
	boardCells add: (aCellGenerator generateWormHoleEntryOn: firstEntrance between: firstEntrance and: secondEntrance).
	(firstEntrance + 1) to: (secondEntrance - 1) do: [ :i | boardCells add: (aCellGenerator determineATypeOfCellOn: i) ].
	boardCells add: (aCellGenerator generateWormHoleEntryOn: secondEntrance between: firstEntrance and: secondEntrance).
	(secondEntrance + 1) to: numberOfCells do: [ :i | boardCells add: (aCellGenerator determineATypeOfCellOn: i) ].
	
	^ self withATotalNumberOfCellsOf: numberOfCells whichAre: boardCells andAWormHoleBetweenCells: firstEntrance and: secondEntrance

]

{ #category : 'as yet unclassified' }
Board class >> withATotalNumberOfCellsOf: numberOfCells whichAre: theseCells andAWormHoleBetweenCells: firstEntrance and: secondEntrance [
 
    self isAPositiveInteger: numberOfCells.
    self isAPositiveInteger: firstEntrance.
    self isAPositiveInteger: secondEntrance.

    self theCell: firstEntrance isOutOfRange: numberOfCells.
    self theCell: secondEntrance isOutOfRange: numberOfCells.

    self the: firstEntrance isDifferentFrom: secondEntrance.
    self the: secondEntrance isSmallerThan: firstEntrance.

    ^ self new initializeWith: numberOfCells
		  andTheseCells: theseCells
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
Board >> cells [

	^ cells.


]

{ #category : 'accessing' }
Board >> determineAndApplyEffectTo: aShip atCurrentCellFrom: aGame [

	| specialCell cellsState |
	specialCell := cells at: (aGame positionOf: aShip).
	cellsState := specialCell currentState.
	cellsState applyEffectTo: aShip in: specialCell from: aGame.
	
	^ specialCell.
]

{ #category : 'accessing' }
Board >> getShipsIntoFirstCellOfTheBoard: shipsCollection [

    | startCell |

    startCell := cells first.
    shipsCollection do: [ :aShip | startCell enters: aShip ].


]

{ #category : 'initialization' }
Board >> initializeWith: aNumberOfCells andTheseCells: someCells andAWormHoleBeweenCells: firstEntrance and: secondEntrance [

	cells := OrderedCollection withAll: someCells.
	wormsHolesFirstEntrance := firstEntrance.
	wormsHolesSecondEntrance := secondEntrance.
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
