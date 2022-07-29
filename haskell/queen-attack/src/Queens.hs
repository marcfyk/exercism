module Queens (boardString, canAttack) where
import Data.List (groupBy, intersperse)

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString Nothing Nothing = (concat . formatBoard) board
boardString white black = (concat 
    . formatBoard 
    . unindexBoard 
    . setPieces white black 
    . indexBoard) board

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (a, b) (c, d)
    | a == c = True
    | b == d = True
    | abs(a - c) == abs(b - d) = True
    | otherwise = False

board :: [String]
board = (replicate 8 . replicate 8) '_'

data Coord = Coord Int Int deriving Eq

sameRow :: Coord -> Coord -> Bool
sameRow (Coord x _) (Coord y _) = x == y

indexBoard :: [String] -> [(Coord, Char)]
indexBoard b = do
    (x, row) <- zip [0..] b
    (y, value) <- zip [0..] row
    return (Coord x y, value)

unindexBoard :: [(Coord, Char)] -> [String]
unindexBoard = (map . map) snd
    . groupBy (\x y -> sameRow (fst x) (fst y))

setBoard :: Coord -> Char -> [(Coord, Char)] -> [(Coord, Char)]
setBoard coord c = map (\(i, v) -> (i, if coord == i then c else v))

setPieces :: Maybe (Int, Int) -> Maybe (Int, Int) -> [(Coord, Char)]
    -> [(Coord, Char)]
setPieces Nothing Nothing = id
setPieces (Just (a, b)) Nothing = setBoard (Coord a b) 'W'
setPieces Nothing (Just (c, d)) = setBoard (Coord c d) 'B'
setPieces white black = setPieces white Nothing . setPieces Nothing black

formatBoard :: [String] -> [String]
formatBoard = map ((++"\n") . intersperse ' ')
