module WordProblem (answer) where

answer :: String -> Maybe Integer
answer problem = validateQuestionMark problem
    >>= (Just . words)
    >>= validateQuestionFormat 
    >>= validateOperator

validateQuestionMark :: String -> Maybe String
validateQuestionMark xs
    | last xs == '?' = (Just . init) xs
    | otherwise = Nothing

validateQuestionFormat :: [String] -> Maybe [String]
validateQuestionFormat ("What":"is":question) = Just question
validateQuestionFormat _ = Nothing

validateOperator :: [String] -> Maybe Integer
validateOperator [x] =  (Just . read) x
validateOperator (x:"plus":y:rest) = validateOperator (plus x y:rest)
validateOperator (x:"minus":y:rest) = validateOperator (minus x y:rest)
validateOperator (x:"multiplied":"by":y:rest) = validateOperator (multiply x y:rest)
validateOperator (x:"divided":"by":y:rest) = validateOperator (divide x y:rest)
validateOperator _ = Nothing

plus :: String -> String -> String
plus x y = show $ (read x :: Int) + read y
minus :: String -> String -> String
minus x y = show $ (read x :: Int) - read y
multiply :: String -> String -> String
multiply x y = show $ (read x :: Int) * read y
divide :: String -> String -> String
divide x y = show $ (read x :: Int) `div` read y

