module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum [n |
    n <- [1..limit-1],
    any (\f -> f /= 0 && mod n f == 0) factors]
