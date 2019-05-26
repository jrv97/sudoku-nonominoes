-- Este es el modulo Main. Aqui se llama a las funciones de ensamblar los nonominos para formar el sudoku
-- y luego a la que intenta resolverlo. Es el entry point del proyecto.

import SudokuNonominoesDeclaration
import AssembleSudoku
import SolveSudoku
import DataStructures

solution :: Maybe Sudoku
solution
    | assembled == Nothing = error "¡Imposible resolver el Sudoku!"
    | otherwise = let Just solved = assembled in solveSudoku solved
    where assembled = assembleSudoku nns

-- saveSolution :: Maybe Sudoku
saveSolution sol = writeFile "Solution.txt" (show sol)
