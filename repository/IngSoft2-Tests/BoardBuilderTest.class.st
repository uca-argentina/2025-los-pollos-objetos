Class {
	#name : 'BoardBuilderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardBuilderTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
BoardBuilderTest >> testWhenBoardBuilderIsSetToBuildABoardWithAGivenNumberOfCellsThenItBuildsIt [
	| builder board |
	builder := BoardBuilder new.
	builder withCells: 5.
	board := builder build.
	self assert: board numberOfCells equals: 5.
]

{ #category : 'tests' }
BoardBuilderTest >> testWhenBoardBuilderIsSetWithBlackHoleThenABoardWithBlackHolesIsCreated [
	| builder board |
	builder := BoardBuilder new.
	builder withCells: 10.
	builder withBlackHoleFrom: 3 to: 8.
	board := builder build.
	self assert: board blackHolesFirstEntrance equals: 3.
	self assert: board blackHolesSecondEntrance equals: 8.
]

{ #category : 'tests' }
BoardBuilderTest >> testWhenBoardBuilderTriesToBuildABoardWithABlackHoleOnOneSameCellThenCreationFails [
	self
		should: [
			(BoardBuilder new
				withCells: 5;
				withBlackHoleFrom: 3 to: 3)
				build ]
		raise: Error
		withMessageText: 'The entrances of the Black Hole must be in different cells'.
]

{ #category : 'tests' }
BoardBuilderTest >> testWhenBoardBuilderTriesToBuildABoardWithABlackHoleOutOfRangeThenCreationFails [
	self
		should: [
			(BoardBuilder new
				withCells: 5;
				withBlackHoleFrom: 2 to: 6)
				build ]
		raise: Error
		withMessageText: 'The Black Hole entrance must be within the valid range of board cells (1 to 5).'.

]

{ #category : 'tests' }
BoardBuilderTest >> testWhenBoardBuilderTriesToBuildWithANegativeNumberOfCellsThenCreationFails [
	self 
		should: [ BoardBuilder new withCells: -3 ] 
		raise: Error 
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardBuilderTest >> testWhenBoardBuilderTriesToCreateABoardWithZeroCellsThenCreationFails [
	self 
		should: [ BoardBuilder new withCells: 0 ] 
		raise: Error 
		withMessageText: 'Number of cells must be a positive integer.'.
]
