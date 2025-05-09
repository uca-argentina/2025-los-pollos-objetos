Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [ 

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [:error | self assert: (error messageText ) equals: errorMessage]
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceAndSecondEntranceAreEqualThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: 1 to: 1.
			builder build.
		]
		raise: Error
		withMessageText: 'The entrances of the Black Hole must be in different cells'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceIsANegativeCellThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: -2 to: 6.
			builder build.
		]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesFirstEntranceIsNonIntegerThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: 'dos' to: -10.
			builder build.
		]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceCellIsSmallerThanBlackHolesFirstEntranceCellThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: 4 to: 1.
			builder build.
		]
		raise: Error
		withMessageText: 'The First Entrance of Black Hole must come before the Second Entrance'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceIsANegativeCellThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: 2 to: -10.
			builder build.
		]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceIsNonIntegerThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: 2 to: 'diez'.
			builder build.
		]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHolesSecondEntranceIsOutOfBoardsRangeThenCreationFails [

	| builder |
	builder := BoardBuilder new.

	self
		should: [
			builder withCells: 10.
			builder withBlackHoleFrom: 2 to: 11.
			builder build.
		]
		raise: Error
		withMessageText: 'The cells of the Black Hole must be in the board.'.

]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithInvalidNumberOfCellsThenItFails [

	| builder |
	builder := BoardBuilder new.
	
	self
		should: [ 
			builder withCells: -1.
			builder build. 
		]
		raise: Error 
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithNonIntegerThenItFails [

	| builder |
	builder := BoardBuilder new.
	
	self
		should: [ 
			builder withCells: 'dos'.
			builder build. 
		]
		raise: Error 
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithZeroCellsThenItFails [

	| builder |
	builder := BoardBuilder new.

	self 
		should: [ 
			builder withCells: 0.
			builder build. 
		]
		raise: Error 
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithOneCellThenHasOneCell [

	| aBoard aBoardBuilder |
	"aBoard := Board new."
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 1.
	aBoard := aBoardBuilder build.

	self assert: (aBoard numberOfCells) equals: 1.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithTenCellsThenHasTenCells [

	| aBoard aBoardBuilder |
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 10.
	aBoard := aBoardBuilder build.
	
	self assert: (aBoard numberOfCells) equals: 10.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsSetWithABlackHoleThenItHasAFirstEntrance [

	| aBoard aBoardBuilder |
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 10.
	aBoardBuilder withBlackHoleFrom: 5 to: 10.
	aBoard := aBoardBuilder build.
	
	self assert: (aBoard blackHolesFirstEntrance) equals: 5.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsSetWithABlackHoleThenItHasASecondEntrance [

	| aBoard aBoardBuilder |
	
	aBoardBuilder := BoardBuilder new.
	aBoardBuilder withCells: 10.
	aBoardBuilder withBlackHoleFrom: 5 to: 10.
	aBoard := aBoardBuilder build.
	
	self assert: (aBoard blackHolesSecondEntrance ) equals: 10.
]
