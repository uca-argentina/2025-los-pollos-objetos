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
BoardTest >> testAWhenBlackHolesFirstEntranceAndSecondEntranceAreEqualThenCreationFails [

	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: 4 and: 4 ]  
		raise: Error
		withMessageText: 'The entrances of the Black Hole must be in different cells.'.
		
]

{ #category : 'tests' }
BoardTest >> testAWhenBlackHolesFirstEntranceIsOutOfBoardsRangeThenCreationFails [

	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: 9 and: 19 ]  
		raise: Error
		withMessageText: 'The entrances of the black hole must be in the board'.

]

{ #category : 'tests' }
BoardTest >> testAWhenBlackHolesSecondEntranceCellIsSmallerThanBlackHolesFirstEntranceCellThenCreationFails [
	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: 7 and: 4 ]  
		raise: Error
		withMessageText: 'The First Entrance of Black Hole must come before the Second Entrance.'.

]

{ #category : 'tests' }
BoardTest >> testAWhenBlackHolesSecondEntrnaceIsOutOfBoardsRangeThenCreationFails [
	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: 1 and: 9 ]  
		raise: Error
		withMessageText: 'The entrances of the black hole must be in the board'.

]

{ #category : 'tests' }
BoardTest >> testAWhenBoardCreatedWithZeroCellsThenItFails [

	| aSquare squares |
	aSquare := Square new.
	squares := OrderedCollection  new.
	
	self
		should: [Board   withSquares: squares .]
		raise: Error
		withMessageText: 'Number of cells must be a positive integer.'.
		"HAY QUE CAMBIAR EL CELLS POR SQUARES"
]

{ #category : 'tests' }
BoardTest >> testAWhenBoardIsCreatedWithOneCellThenHasCell [

	| aBoard aSquare squares |
	
	aSquare := Square new.
	squares := OrderedCollection  new.
	squares add: aSquare.
	
	aBoard := Board withSquares: squares.
	
	
	self assert: (aBoard numberOfSquares) equals: 1.
]

{ #category : 'tests' }
BoardTest >> testAWhenBoardIsSetWithABlackHoleThenTheBoardHasTwoBlackHolesSquares [
	| aBoard  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	squares addBlackHoleAt: 1 and: 2.
	
	aBoard := Board withSquares: squares.
	
	self assert: (aBoard blackHolesIndexes anySatisfy: [ :index | index = 1]).
	self assert: (aBoard blackHolesIndexes anySatisfy: [ :index | index = 2]).
	
]

{ #category : 'tests' }
BoardTest >> testAWhenBoardIsSetWithABlackHoleWithAnCharFirstEntranceThenTheCreationFailed [
	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: '1' and:2 ]  
		raise: Error
		withMessageText: 'The entrance of the black hole must be a positive integer'.

	
]

{ #category : 'tests' }
BoardTest >> testAWhenBoardIsSetWithABlackHoleWithAnCharSecondEntranceThenTheCreationFailed [
	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: 1 and: '2' ]  
		raise: Error
		withMessageText: 'The entrance of the black hole must be a positive integer'.

	
]

{ #category : 'tests' }
BoardTest >> testAWhenBoardIsSetWithABlackHoleWithAnInvalidFirstEntranceThenTheCreationFailed [
	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: -1 and:2 ]  
		raise: Error
		withMessageText: 'The entrance of the black hole must be a positive integer'.

	
]

{ #category : 'tests' }
BoardTest >> testAWhenBoardIsSetWithABlackHoleWithAnInvalidSecondEntranceThenTheCreationFailed [
	|  squares  numberOfSquares |
	
	numberOfSquares := 8.
	
	squares := OrderedCollection  new.
	
	1 to: numberOfSquares do: [:i |squares add: (Square new) ].
	
	self should: [squares addBlackHoleAt: 1 and: -2 ]  
		raise: Error
		withMessageText: 'The entrance of the black hole must be a positive integer'.

	
]
