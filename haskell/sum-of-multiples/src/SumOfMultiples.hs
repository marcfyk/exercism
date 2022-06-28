module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum [x | x <- [1..limit - 1], any (\factor -> factor /= 0 && mod x factor == 0) factors]
