module Anagram (anagramsFor) where

import Data.List (sort)
import Data.Char (toUpper)

anagramsFor :: String -> [String] -> [String]
anagramsFor xs = filter isAnagram
    where
        isAnagram ys = upperXs /= upperYs && sort upperXs == sort upperYs
            where
                upperXs = map toUpper xs
                upperYs = map toUpper ys
