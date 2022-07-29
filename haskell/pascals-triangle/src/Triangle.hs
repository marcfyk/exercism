module Triangle (rows) where

rows :: Int -> [[Integer]]
rows 0 = []
rows 1 = [[1]]
rows x = [1]:buildRows (toInteger x-1) [1]

windows :: Int -> [Integer] -> [[Integer]]
windows 0 _ = []
windows _ [] = []
windows n xs
    | length xs < n = []
    | otherwise = window:rest
    where 
        window = take n xs
        rest = (windows n . drop 1) xs

buildRows :: Integer -> [Integer] -> [[Integer]]
buildRows 0 _ = []
buildRows n prev = row:rest
    where
        middle = (map sum . windows 2) prev
        row = 1:middle ++ [1]
        rest = buildRows (n-1) row
