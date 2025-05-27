Class {
	#name : 'HyperJumpCellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpCellTest >> testBanan [

| aGame aBoard aShip ships oneDice dices hyperJumpCell boardLengthInParsecs parsecValues expectedPosition cellLengthInParsecs |
    
    "Supongamos: el tablero mide 100 parsecs y tiene 10 casilleros => cada casillero mide 10 parsecs"
    boardLengthInParsecs := 100.
    cellLengthInParsecs := 10.
    parsecValues := #(25 15 10). "La lista de valores a asignar a la celda HyperJump"

    aBoard := Board withATotalNumberOfCellsOf: 10 andAWormHoleBetweenCells: 2 and: 3. "El Board debería aceptar el largo en parsecs, habría que modificar el modelo para eso"

    hyperJumpCell := HyperJumpCell initializeCellOn: 4 withParsecValues: parsecValues boardLength: boardLengthInParsecs numberOfCells: 10.

    aBoard changeCellAt: 4 to: hyperJumpCell.

    aShip := Ship named: 'Venture'.
    ships := OrderedCollection with: aShip.

    oneDice := ChargedDice withATotalNumberOfFacesOf: 3.  
    dices := OrderedCollection with: oneDice.

    aGame := Game
        completedAtLap: 1
        with: aBoard
        and: dices
        and: ships.

    "Fuerzo a la nave a caer justo en la celda 4, después de tirar los dados"
    aGame executeTurn .

    "La nave debería saltar una cantidad de casilleros igual a la cantidad de parsecs que toca, dividido el largo de casillero"
    "Primer valor de la lista es 25 parsecs: 25 / 10 = 2,5 casilleros => avanza 2 casilleros (redondear hacia abajo o hacia arriba según lo que decidan como regla del juego)"

    expectedPosition := 4 + (25 // cellLengthInParsecs).
    "Esperamos que termine en la casilla 6 (4 + 2) si truncamos el decimal"

    self assert: aShip position equals: expectedPosition.

    "Opcional: verificar que el siguiente salto use el siguiente valor de la lista"
]
