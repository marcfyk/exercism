module Bob (responseFor) where

import qualified Data.Char
import qualified Data.List

trim :: String -> String
trim = Data.List.dropWhile Data.Char.isSpace . Data.List.dropWhileEnd Data.Char.isSpace

responseFor :: String -> String
responseFor xs
  | isEmpty             = "Fine. Be that way!"
  | isUpperCaseQuestion = "Calm down, I know what I'm doing!"
  | isUpperCase         = "Whoa, chill out!"
  | isQuestion          = "Sure."
  | otherwise           = "Whatever."
  where
    text = trim xs
    isEmpty = null text
    isQuestion = Data.List.isSuffixOf "?" text
    isUpperCase = (not . null) letters && all Data.Char.isUpper letters
      where letters = filter Data.Char.isLetter text
    isUpperCaseQuestion = isUpperCase && isQuestion
    



