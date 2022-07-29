module Phone (number) where
import Data.Char (isNumber)

number :: String -> Maybe String
number n = removeNonNumbers n >>= validateLength >>= validateDigits

removeNonNumbers :: String -> Maybe String
removeNonNumbers = Just . filter isNumber

validateLength :: String -> Maybe String
validateLength n
    | len < 10 = Nothing
    | len == 10 = Just n
    | len == 11 && head n == '1' = (Just . tail) n
    | otherwise = Nothing
    where len = length n

validateDigits :: String -> Maybe String
validateDigits xs@(n1:_:_:n2:_)
    | n1 `elem` range && n2 `elem` range = Just xs
    | otherwise = Nothing
    where range = ['2'..'9']
validateDigits _ = Nothing
