module CryptoSquare (encode) where
import Data.Char (toLower, isAlphaNum)
import Data.List (transpose)

encode :: String -> String
encode = unwords . transpose . chunks . normalize

normalize :: String -> String
normalize = concat . words . map toLower . filter isAlphaNum

columnLength :: String -> Int
columnLength xs = (ceiling . sqrt) (fromIntegral $ length xs :: Float)

chunks :: String -> [String]
chunks xs = let c = columnLength xs in chunkEvery xs c

chunkEvery :: String -> Int -> [String]
chunkEvery xs c = leftChunk:rightChunks
    where
        (left, right) = splitAt c xs
        leftChunk = pad left c
        rightChunks
            | right == "" = []
            | length right < c = [pad right c]
            | otherwise = chunkEvery right c

pad :: String -> Int -> String
pad xs n
    | length xs >= n = xs
    | otherwise = xs ++ replicate (n - length xs) ' '
