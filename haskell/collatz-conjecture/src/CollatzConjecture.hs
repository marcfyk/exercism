module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz 1 = Just 0
collatz n =
  if n <= 0
    then Nothing
    else
      let steps = if even n
                    then collatz $ div n  2
                    else collatz $ 3 * n + 1
      in case steps of Just c -> Just $ c + 1
                       Nothing -> Nothing
