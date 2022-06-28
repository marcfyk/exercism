module Pangram (isPangram) where

import qualified Data.List
import qualified Data.Char

getDistinctLetters :: String -> Int
getDistinctLetters = length
  . filter (>='a')
  . filter (<='z')
  . Data.List.nub 
  . map Data.Char.toLower

isPangram :: String -> Bool
isPangram text = length ['a'..'z'] == getDistinctLetters text
  
