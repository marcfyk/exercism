module Prime (nth) where

nth :: Int -> Maybe Integer
nth n
    | n > 0 = Just $ toInteger $ [x | x <- [2..], isPrime x] !! (n - 1)
    | otherwise = Nothing

isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | n == 2 = True
    | otherwise = not $ any (\x -> rem n x == 0) [2..limit]
        where 
            limit = ceiling ( sqrt (fromIntegral n) :: Float) :: Int
