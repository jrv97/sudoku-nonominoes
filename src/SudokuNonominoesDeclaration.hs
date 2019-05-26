module SudokuNonominoesDeclaration where

import DataStructures


cells0 = [ Cell { row = -1, col = -1, num = 3, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 2, posInNonomino = (1, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, 1) } ]

nono0 = Nonomino {cells = cells0, nonoID = 0, inUse = False }


cells1 = [ Cell { row = -1, col = -1, num = 1, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 9, posInNonomino = (0, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 3) }, Cell { row = -1, col = -1, num = 5, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, -1) }, Cell { row = -1, col = -1, num = 2, posInNonomino = (2, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 2) } ]

nono1 = Nonomino {cells = cells1, nonoID = 1, inUse = False }


cells2 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 2) }, Cell { row = -1, col = -1, num = 6, posInNonomino = (0, 3) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 9, posInNonomino = (2, -1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 2) } ]

nono2 = Nonomino {cells = cells2, nonoID = 2, inUse = False }


cells3 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 1, posInNonomino = (0, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 3) }, Cell { row = -1, col = -1, num = 8, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, -1) }, Cell { row = -1, col = -1, num = 4, posInNonomino = (2, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 1) }, Cell { row = -1, col = -1, num = 6, posInNonomino = (2, 2) } ]

nono3 = Nonomino {cells = cells3, nonoID = 3, inUse = False }


cells4 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 8, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 2) }, Cell { row = -1, col = -1, num = 3, posInNonomino = (1, 3) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 3) }, Cell { row = -1, col = -1, num = 1, posInNonomino = (2, 4) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 5) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, 5) } ]

nono4 = Nonomino {cells = cells4, nonoID = 4, inUse = False }


cells5 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 4, posInNonomino = (1, 2) }, Cell { row = -1, col = -1, num = 5, posInNonomino = (2, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 3) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 4) } ]

nono5 = Nonomino {cells = cells5, nonoID = 5, inUse = False }


cells6 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 3) }, Cell { row = -1, col = -1, num = 4, posInNonomino = (0, 4) }, Cell { row = -1, col = -1, num = 1, posInNonomino = (1, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 3) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 4) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 4) } ]

nono6 = Nonomino {cells = cells6, nonoID = 6, inUse = False }


cells7 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 0) }, Cell { row = -1, col = -1, num = 6, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 2) }, Cell { row = -1, col = -1, num = 8, posInNonomino = (2, 2) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 3) }, Cell { row = -1, col = -1, num = 2, posInNonomino = (2, 4) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, 4) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, 5) } ]

nono7 = Nonomino {cells = cells7, nonoID = 7, inUse = False }


cells8 = [ Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (0, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (1, 1) }, Cell { row = -1, col = -1, num = 9, posInNonomino = (2, -1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 0) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (2, 1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, -1) }, Cell { row = -1, col = -1, num = 0, posInNonomino = (3, 0) }, Cell { row = -1, col = -1, num = 7, posInNonomino = (3, 1) } ]

nono8 = Nonomino {cells = cells8, nonoID = 8, inUse = False }



nns = [nono0, nono1, nono2, nono3, nono4, nono5, nono6, nono7, nono8]

sudoku = Sudoku { nonominoes = nns }