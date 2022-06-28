module Acronym (abbreviate) where

import Data.List
import Data.Char

abbreviate :: String -> String
abbreviate xs = map capitalizeWord $ getWords xs

getWords = words . parseWords

capitalizeWord = Data.Char.toUpper . head

parseWords [] = []
parseWords (first:second:tail)
    | Data.Char.isLower first && Data.Char.isUpper second = first:' ':second:(parseWords tail)
parseWords (head:tail)
    | head == '-' = ' ':(parseWords tail)
    | head == '_' = ' ':(parseWords tail)
    | otherwise = head:(parseWords tail)
