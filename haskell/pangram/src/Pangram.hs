module Pangram (isPangram) where
import Data.Char (isLetter, toLower, isAscii)
import Data.List (nub)

isPangram :: String -> Bool
isPangram text = 26 == length distinctLetters
    where distinctLetters = nub [toLower c | c <- text, isLetter c, isAscii c]
