-- En este modulo se encuentran todas las funciones necesarias para "ensamblar" los
-- nonominos de forma tal que generen un tablero valido


module AssembleSudoku where
import Data.List -- esto es para usar \\ que es el operador de diferencia de listas
import DataStructures


-- Devuelve True ssi la posicion (x, y) esta dentro de los limites del sudoku
-- i.e. (0, 0) <= (x, y) < (9,9)
validPosition :: (Int, Int) -> Bool
validPosition (x, y) = elem x [0..8] && elem y [0..8]


-- Devuelve una lista con las posiciones libres, o sea, las que no pertenecen
-- a ningun nonomino
getAvailablePositions :: [Nonomino] -> [(Int, Int)]
getAvailablePositions nns =
    let
        allPositions = [(x, y) | x <- [0..8], y <- [0..8]]
        positionsInUse = [(row c, col c) | c <- getAllCells nns]
    in allPositions \\ positionsInUse


-- Devuelve la posicion mas arriba y mas a la izquiera que no esta en ninguno
-- de los nonominos fijados hasta el momento.
getTopMostLeftMostFreePosition :: [Nonomino] -> (Int, Int)
getTopMostLeftMostFreePosition nns
    | available /= [] = minimum available
    | otherwise = (-1,-1) -- significa que se lleno el tablero
    where
        available = getAvailablePositions nns


-- Dados (x1, y1) y (x2, y2) devuelve (x1+x2, y1+y2). Se usa para calcular la
-- posicion nueva de una celda en funcion de su posicion en el nonomino, ya
-- que su posicion en el nonomino es la posicion relativa que tiene en el nonomino
-- con respecto al elemento mas arriba y a la izquierda de este.
calculateNewPosition :: (Int, Int) -> (Int, Int) -> (Int, Int)
calculateNewPosition a b = let
    newX = (fst a + fst b)
    newY = (snd a + snd b)
    in (newX, newY)


-- Dada la lista de nonominos y la posicion de un nonomino en esa lista, intenta
-- fijar ee nonomino en la posicion disponible mas a la derecha y mas arriba del
-- tablero. Si es posible, devuelve True y el nuevoNonominno resultante de fijar
-- el anterior, y si no puede entonces devuelve False y el nonomino en la posicion
-- especificada. Para verificar si puede hacerlo, intenta fijar cada casilla del
-- nonomino en la nueva posicion que le toca (a partir de la posicion libre
-- calculada y de las posicones relativas de las celdas del nonomino). Si pudo
-- fijar exactamente 9 casillas del nonomino, significa que fijo el nonomino.
fixNonomino :: [Nonomino] -> Int -> (Bool, Nonomino)
fixNonomino nns nnPos
    | inUse nonomino = (False, nonomino)
    | not (validPartialSolution nns) = (False, nonomino)
    | length cls == 9 = (True, Nonomino { cells = cls, nonoID = idn, inUse = True })
    | otherwise = (False, nonomino)
    where
        nonomino = nns !! nnPos
        idn = nonoID nonomino
        firstFreePos = getTopMostLeftMostFreePosition nns
        cls = [
            Cell {row = fst newPos, col = snd newPos, num = num c, posInNonomino = posInNonomino c} |
            c <- cells nonomino,
            let newPos = calculateNewPosition firstFreePos (posInNonomino c),
            validPosition newPos && (elem newPos (getAvailablePositions nns))
            ]


-- Dada una lista de nonominos y una posicion de la misma intenta ubicar el nonomino de esa posicion
-- en la posicion vacia mas arriba y mas a la izquierda del tablero usando fixNonomino. Si no pudo,
-- devuelve la misma lista de nonominos, y si pudo entonces devuelve esa misma lista pero actualizando
-- el nonomino de la posicion dada con los nuevos valores que tomaron sus celdas al ubicarlo.
orderNonominoes :: [Nonomino] -> Int -> (Bool, [Nonomino])
orderNonominoes currentState nnPos
    | succeeded = (True, newState)
    | otherwise = (False, currentState)
    where
        try = fixNonomino currentState nnPos
        succeeded = (fst try)
        tryNono = snd try
        newState = map (\x -> if nonoID x /= nonoID tryNono then x else tryNono) currentState


-- Tomando en cuenta los nonominos, intenta "ensamblarlos" de forma tal que generen un tablero de sudoku valido.
-- En cada paso, verifica no solo si el nonomino "encaja" en una posicion, sino que ademas verifica si el poner
-- dicho nonomino en dicha posicion generaria un sudoku valido (ver validPartialSolution). Si no es posible lograr
-- esto, en algun momento, entonces se devuelve [] y el backtrack se encarga de seguir probando otras formas de
-- ensamblar los nonominos. En caso de que el sudoku no se pueda "ensamblar" con los nonominos ofrecidos, entonces
-- se devuelve Nothing. (ver firstNotNothing)
assembleSudoku :: [Nonomino] -> Maybe Sudoku
assembleSudoku nns
    | doneAssembling = Just Sudoku { nonominoes = nns }
    | otherwise = let
        nonos = [
            assembleSudoku(tryNonos) |
            nnPos <- [0..8],
            let (succeeded, tryNonos) = orderNonominoes nns nnPos,
            succeeded,
            validPartialSolution(tryNonos)
            ]
        in
            firstNotNothing nonos
    where
        doneAssembling = (getTopMostLeftMostFreePosition nns) == (-1,-1)


-- Permite validar si una disposicion de los nonominos podria o no generar un sudoku valido.
-- Para ello, verifica que con dicha disposicion no quedan elementos repetidos por filas ni
-- por columnas.
validPartialSolution :: [Nonomino] -> Bool
validPartialSolution nonos =
    let
        validCols = validRowsOrCols nonos getCol
        validRows = validRowsOrCols nonos getRow
    in
        validCols && validRows


-- Devuelve True ssi la celda especificada aun no ha sido colocada para formar el sudoku.
isFixed :: Cell -> Bool
isFixed c = (row c /= -1) && (col c /= -1)
