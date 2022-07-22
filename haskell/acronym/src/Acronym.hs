module Acronym (abbreviate) where
import Data.Char (isUpper, toUpper, isAlpha)

abbreviate :: String -> String
abbreviate xs =
    concatMap (getAcronymLetters . dropWhile (not . isAlpha))
    $ words xs
    where
        getTrailingLetters [] = []
        getTrailingLetters (x:rest)
            | isUpper x = x:(getTrailingLetters . dropWhile isUpper) rest
            | x == '-' = getAcronymLetters rest
            | otherwise = getTrailingLetters rest
        getAcronymLetters [] = []
        getAcronymLetters (x:_:rest)
            | isAlpha x = toUpper x:restOfLetters
            | otherwise = restOfLetters
            where restOfLetters = (getTrailingLetters . dropWhile isUpper) rest
        getAcronymLetters [x]
            | isAlpha x = [toUpper x]
            | otherwise = []
