module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz 1 = Just 0
collatz n
    | n < 1 = Nothing
    | even n = succ <$> (collatz $ div n 2)
    | otherwise = succ <$> (collatz $ n * 3 + 1)
