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
BoardTest >> testWhenBlackHoleEntryIsInTheSeccondCellThenItPass [

	| aBoard |
	
	aBoard := Board withATotalNumberOfCellsOf: 10 withABlackHoleIn: 2  wichOutIs: 6.
	
	self assert: (aBoard blackHoleEntry) equals: 2.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHoleEntryIsNegativeThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: 10 withABlackHoleIn: -2  wichOutIs: 6.]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHoleEntryIsNonIntegerThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: 10 withABlackHoleIn: '2'  wichOutIs: 6.]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHoleExitIsInTheSixthCellThenItPass [

	| aBoard |
	
	aBoard := Board withATotalNumberOfCellsOf: 10 withABlackHoleIn: 2  wichOutIs: 6.
	
	self assert: (aBoard blackHoleExit ) equals: 6.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHoleExitIsNegativeThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: 10 withABlackHoleIn: 2  wichOutIs: -6.]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBlackHoleExitIsNonIntegeThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: 10 withABlackHoleIn: 2  wichOutIs: '6'.]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithInvalidNumberOfCellsThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: -1]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithNonIntegerThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: 'uno']
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardCreatedWithZeroCellsThenItFails [

	self
		should: [Board withATotalNumberOfCellsOf: 0]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithOneCellThenHasCell [

	| aBoard |
	"aBoard := Board new."
	
	aBoard := Board withATotalNumberOfCellsOf: 1.
	
	self assert: (aBoard numberOfCells) equals: 1.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithTenCellsThenHasTenCells [

	| aBoard |
	
	aBoard := Board withATotalNumberOfCellsOf: 10.
	
	self assert: (aBoard numberOfCells) equals: 10.
]
