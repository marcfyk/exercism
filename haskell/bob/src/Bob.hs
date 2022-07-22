module Bob (responseFor) where

import qualified Data.Text as T
import Data.Char (isUpper, isAlpha, isSpace)

responseFor :: String -> String
responseFor xs
    | isQuestion && isShouting = "Calm down, I know what I'm doing!"
    | isShouting = "Whoa, chill out!"
    | isQuestion = "Sure."
    | isEmpty = "Fine. Be that way!"
    | otherwise = "Whatever."
    where
        text = T.dropWhileEnd isSpace $ T.dropWhile isSpace $ T.pack xs
        isEmpty = T.null text
        isQuestion = T.isSuffixOf (T.pack "?") text
        isShouting = isAllUppercase
            where
                letters = T.filter isAlpha text
                isAllUppercase = T.length letters > 0 && T.all isUpper letters
