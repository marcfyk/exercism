module DNA (toRNA) where

getNucleotide :: Char -> Either Char Char
getNucleotide n = case n of 'A'       -> Right 'U'
                            'C'       -> Right 'G'
                            'G'       -> Right 'C'
                            'T'       -> Right 'A'
                            otherwise -> Left n

toRNA :: String -> Either Char String
toRNA xs =
  foldr
  (\c acc -> let n = getNucleotide c
             in case n of Left invalidC -> Left invalidC
                          Right toAdd   -> case acc of Left err    -> Left err
                                                       Right value -> Right (toAdd:value))
  (Right "")
  xs