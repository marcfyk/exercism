module Minesweeper (annotate) where
import Data.List (groupBy)

annotate :: [String] -> [String]
annotate [""] = [""]
annotate board = (unindexBoard . parse . indexBoard) board

indexBoard :: [String] -> [(Int, Int, Char)]
indexBoard = concatMap (\(x, row) -> [(x, y, c) | (y, c) <- zip [0..] row])
    . zip [0..] 

unindexBoard :: [(Int, Int, Char)] -> [String]
unindexBoard = (map . map) (\(_, _, c) -> c)
    . groupBy (\(x1, _, _) (x2, _, _) -> x1 == x2)

adjacentIndexes :: Int -> Int -> [(Int, Int, Char)] -> [(Int, Int, Char)]
adjacentIndexes x y = filter (\(i, j, _) -> i /= x || j /= y)
    . filter (\(i, _, _) -> abs(i - x) <= 1)
    . filter (\(_, j, _) -> abs(j - y) <= 1)

countBombs :: Int -> Int -> [(Int, Int, Char)] -> Int
countBombs x y = length
    . filter (\(_, _, c) -> c == '*')
    . adjacentIndexes x y

mapValue :: (Int, Int, Char) -> [(Int, Int, Char)] -> (Int, Int, Char)
mapValue (x, y, '*') _ =  (x, y, '*')
mapValue (x, y, _) board = (x, y, c)
    where
        count = countBombs x y board
        c = if count == 0 then ' ' else (head . show) count

parse :: [(Int, Int, Char)] -> [(Int, Int, Char)]
parse board = map (`mapValue` board) board

