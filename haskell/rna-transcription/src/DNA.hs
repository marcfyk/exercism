module DNA (toRNA) where

replace :: Char -> Either Char Char
replace 'G' = Right 'C'
replace 'C' = Right 'G'
replace 'T' = Right 'A'
replace 'A' = Right 'U'
replace n = Left n

toRNA :: String -> Either Char String
toRNA = foldr (merge . replace) (Right "")
    where
        merge _ (Left err) = Left err
        merge (Left err) (Right _) = Left err
        merge (Right result) (Right acc) = Right (result:acc)


