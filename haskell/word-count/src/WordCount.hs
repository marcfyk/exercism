module WordCount (wordCount) where
import Data.Char (isAlphaNum, toLower)
import Data.List (dropWhileEnd)
import qualified Data.Map as M

wordCount :: String -> [(String, Int)]
wordCount = M.toList . foldr (\c acc -> M.insertWith (+) c 1 acc) M.empty . normalize

normalize :: String -> [String]
normalize = filter (/= "")
    . map (map toLower 
        . dropWhileEnd (not . isAlphaNum) 
        . dropWhile (not . isAlphaNum))
    . words
    . map (\x -> if x == ',' then ' ' else x)

