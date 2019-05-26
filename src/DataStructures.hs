-- En este modulo se encuentran las funciones especificas a las estructuras de datos Cell, Nonomino y Sudoku
-- que son utilizadas por AssembleSudoku y SolveSudoku.

module DataStructures where

------------------------------------------------------------------------------- CELL-------------------------------------------------------------------------------------------

data Cell = Cell {
    row :: Int,
    col :: Int,
    num :: Int,
    posInNonomino :: (Int, Int)
} deriving (Show, Eq)

-- Se define el Ord para usar minimum.
instance Ord Cell where
    compare c1 c2 = compare (position2DTo1D c1) (position2DTo1D c2)

-- Devuelve la fila de la celda.
getRow :: Cell -> Int
getRow c = row c

-- Devuelve la columna de la celda.
getCol :: Cell -> Int
getCol c = col c

-- Convierte una posicion bidemensional (x, y) en una lineal usando las dimensiones
-- del sudoku. (i.e. 9x + y, x, y estan entre 0 y 8)
position2DTo1D :: Cell -> Int
position2DTo1D c = 9*(row c)+(col c)

------------------------------------------------------------------------ NONOMINO --------------------------------------------------------------------------------------

data Nonomino = Nonomino {
    cells :: [Cell],
    nonoID :: Int,
    inUse :: Bool
} deriving (Eq, Show)

getNumsInNonomino :: Nonomino -> [Int]
getNumsInNonomino nn = map (\x -> num x) (cells nn)

-- Devuelve una lista con todas las celdas contenidas en una lista de nonominos.
getAllCells :: [Nonomino] -> [Cell]
getAllCells [] = []
getAllCells (n:ns) = (cells n)++getAllCells(ns)

-- Dadas una fila r y una columna c, devuelve el nonomino que contiene la celda con
-- fila r y columna c de una lista de nonominos.
findNonomino :: [Nonomino] -> Int -> Int -> Nonomino
findNonomino [] _ _ = (Nonomino {cells = [], nonoID = -1, inUse = False}) -- esto es solo para evitar el warning de pattern matching no exhaustivo
findNonomino [x] _ _ = x
findNonomino (x:xs) r c = let
    curr = filter (\ci -> (row ci == r) && (col ci == c)) (cells x)
    in (if curr == [] then (findNonomino xs r c) else x)

-- Dice si un nonomino es valido.
validNonomino :: Nonomino -> Bool
validNonomino nm =  validListOfNums [num x | x <- (cells nm)]

------------------------------------------------------------------------- SUDOKU ------------------------------------------------------------------------------------

data Sudoku = Sudoku {
    nonominoes :: [Nonomino]
    } deriving (Eq)

instance Show Sudoku where
    show = showSudoku

-- Dice si un sudoku es valido. Esto pasa si sus filas, columnas y nonominos son validos.
validSudoku :: Sudoku -> Bool
validSudoku sud = and [validNonomino nm | nm <- nonominoes sud] && (validRowsOrCols (nonominoes sud) getRow) && (validRowsOrCols (nonominoes sud) getCol)

-- Verifica si un sodoku esta resuelto. Esto ocurre ssi es valido y no hay casillas en 0
-- pero la forma en la que se soluciona el sudoku garantiza que en cada paso el sudoku
-- es valido
isSolved :: Sudoku -> Bool
isSolved (Sudoku nn) = all (\x -> num x /= 0) (getAllCells nn)

--------------------------------------------------------------------- PRINTING SUDOKU -----------------------------------------------------------------------------

showSudoku :: Sudoku -> [Char]
showSudoku (Sudoku nonos) =
    let
        allCells = qsort(getAllCells(nonos))
        rowsRepr = showRows allCells nonos 0
    in
        rowsRepr

showRows :: [Cell] -> [Nonomino] -> Int -> [Char]
showRows [] _ _ = ""
showRows (c:cls) nonos j
    | mod j 10 == 0 = "\n"++(showRows(c:cls) nonos (j+1))
    | otherwise = " "++repr(num c)++":"++(belongingNono)++" "++(showRows cls nonos (j+1))
    where belongingNono = show (nonoID (findNonomino nonos (row c) (col c)))

repr :: Int -> [Char]
repr n
    | n == 0 = " . "
    | otherwise = ""++show n++""

----------------------------------------------------------------------- FUNCIONES AUXILIARES --------------------------------------------------------------------------------------------

-- Quicksort
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = let
    smaller = qsort (filter (<=x) xs)
    larger = qsort (filter (>x) xs)
    in smaller ++ [x] ++ larger

-- De una lista de Maybe devuelve el primero que no sea Nothing. Si la lista esta vacia
-- (o solo contiene Nothing) es pq el metodo que la llamo encontro una via invalida de
-- resolver/ensamblar el sudoku por lo que se devuelve Nothing.
firstNotNothing :: [Maybe a] -> Maybe a
firstNotNothing [] = Nothing
firstNotNothing (Nothing:xs) = firstNotNothing xs
firstNotNothing (x:_) = x

-- Devuelve True ssi en la lista de entrada no hay elementos repetidos (excepto quizas el 0).
validListOfNums :: [Int] -> Bool
validListOfNums [] = True
validListOfNums (0:xs) = validListOfNums xs
validListOfNums (x:xs) = not (elem x xs) && validListOfNums xs

-- El predicado p me dice si lo que tengo que verificar es la validez de filas o de columnas.
-- devuelve True ssi todas las filas/columnas son validas
validRowsOrCols :: [Nonomino] -> (Cell -> Int) -> Bool
validRowsOrCols nonos p = and [validListOfNums (buildListOfNums nonos i p) | i <- [0..8]]

-- El predicado p me dice si lo que estoy construyendo es una fila o una columna
-- devuelve todos los numeros que aparecen en la idx-esima fila o columna
-- (sin contar las casillas vacias, que todas tienen 0)
buildListOfNums :: [Nonomino] -> Int -> (Cell -> Int) -> [Int]
buildListOfNums nonos idx p = [num c | i <- [0..8], let nn = nonos !! i, c <- (cells nn), (p c) == idx, not(num c == 0)]
