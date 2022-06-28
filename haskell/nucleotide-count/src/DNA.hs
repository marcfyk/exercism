module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, fromList, insertWith)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)


getNucleotide :: Char -> Either Char Nucleotide
getNucleotide n = case n of 'A' -> Right A
                            'C' -> Right C
                            'G' -> Right G
                            'T' -> Right T
                            otherwise -> Left n

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs =
  foldr
  (\c acc -> case c of Left err  -> Left "error"
                       Right key -> case acc of Left invalidAcc -> Left "error"
                                                Right prevMap   -> Right $ insertWith (+) key 1 prevMap)
  (Right $ fromList [(A, 0), (C, 0), (G, 0), (T, 0)])
  $ map getNucleotide xs

