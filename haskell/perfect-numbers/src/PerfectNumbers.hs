module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n = factors n >>= (Just . sum) >>= getClassification n

factors :: Int -> Maybe [Int]
factors n
    | n < 1 = Nothing
    | otherwise = Just $ filter ((==0) . mod n) [1..n-1]

getClassification :: Int -> Int -> Maybe Classification
getClassification n a
    | a > n = Just Abundant
    | a < n = Just Deficient
    | otherwise = Just Perfect

