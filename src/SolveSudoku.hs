-- En este modulo se encuentran definidas todas las funciones necesarias para lograr
-- resolver el sudoku.


module SolveSudoku where
import Data.List -- esto es para usar \\ que es el operador de diferencia de listas
import DataStructures


-- Soluciona el sudoku si puede, y si no devuelve Nothing. No es necesario verificar si
-- el sudoku es valido pues esto es una invariante del algoritmo: como en cada llamado se
-- pone un numero valido, el sudoku obtenido en dicha ejecucion es valido. Si en algun
-- momento no se puede poner un numero entonces se devuelve [] y el backtrack se encarga de
-- resolver el sudoku probando con otra secuencia de numeros. En caso de que el sudoku no
-- se pueda resolver, entonces se devuelve Nothing. (ver firstNotNothing)
solveSudoku :: Sudoku -> Maybe Sudoku
solveSudoku sud
    | isSolved sud = Just sud
    | otherwise = let
        bestChoice = smallestCell sud
        sol = [
            solveSudoku (changeCellValue sud bestChoice newValue) |
            newValue <- (getPossibleNums sud bestChoice)
            ]
        in
            firstNotNothing sol

-- Dados un sudoku, una casilla x y un nuevo valor, devuelve el sudoku que es identico al dado
-- excepto que en la casilla x tiene el nuevo valor.
changeCellValue :: Sudoku -> Cell -> Int-> Sudoku
changeCellValue (Sudoku nn) (Cell r c _ p) newValue = let
    newCell = Cell {row = r, col = c, num = newValue, posInNonomino = p}
    nonominoToModify = findNonomino nn r c
    getNewCells = map (\x -> if (row x == r && col x == c) then newCell else x)
    getNewNonominos = map (\x -> if x /= nonominoToModify then x else Nonomino {cells = getNewCells (cells x), nonoID = nonoID x, inUse = True}) nn
    in
        Sudoku { nonominoes = getNewNonominos }

-- Devuelve los posibles numeros que podrian ir en una casilla
getPossibleNums :: Sudoku -> Cell -> [Int]
getPossibleNums (Sudoku nn) (Cell r c n nnPos) =
    if n /= 0 then [0..9] -- nunca va a analizar esta pq tiene longitud 10
    else
        let
            numsInRow = buildListOfNums (nonominoes (Sudoku nn)) r getRow
            numsInCol = buildListOfNums (nonominoes (Sudoku nn)) c getCol
            numsInNonomino = getNumsInNonomino (findNonomino nn r c)
        in
            [1..9] \\ (numsInRow ++ numsInCol ++ numsInNonomino)

-- Devuelve la celda con menor cantidad de elementos posibles. Esto es solamente una forma
-- de seleccionar la proxima celda a cambiar, y elegir la de menores valores posibles para
-- cambiar disminuye la cantidad de pasos del algoritmo considerablemente
smallestCell :: Sudoku -> Cell
smallestCell (Sudoku nn) =
    let
        allCells = getAllCells nn
        -- cellsByPossibleValues :: [(Int, Cell)]
        cellsByPossibleValues = [
            (possibleTotal, c) |
            c <- allCells,
            let possibleTotal = length (getPossibleNums (Sudoku nn) c),
            num c == 0
            ]
        mnm = minimum cellsByPossibleValues
    in
        snd mnm
