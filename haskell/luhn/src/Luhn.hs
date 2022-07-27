module Luhn (isValid) where
import Data.Char (digitToInt, isNumber)

isValid :: String -> Bool
isValid n
    | length normalized <= 1 = False
    | otherwise = rem (checksum normalized) 10 == 0
        where normalized = normalize n

normalize :: String -> String
normalize = filter isNumber

toNumbers :: String -> [Int]
toNumbers = map digitToInt

doubleDigits :: [Int] -> [Int]
doubleDigits = zipWith (\i x -> if even i then x else x * 2) [(0::Int)..] . reverse

subtractDigits :: [Int] -> [Int]
subtractDigits = map (\x -> if x > 9 then x - 9 else x)

checksum :: String -> Int
checksum = sum . subtractDigits . doubleDigits . toNumbers
