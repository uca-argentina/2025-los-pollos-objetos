Class {
	#name : 'OverloadCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
OverloadCard >> applyFrom: aShip to: anotherShip in: aSpaceShipGame [ 
	
	anotherShip changeThrowBy: 2.
]
