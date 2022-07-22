module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, empty, insertWith)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts = foldr (merge . getNucleotide) (Right Data.Map.empty)
    where
        getNucleotide 'A' = Right A
        getNucleotide 'C' = Right C
        getNucleotide 'G' = Right G
        getNucleotide 'T' = Right T
        getNucleotide _ = Left ""
        updateMap key = insertWith (+) key 1
        merge _ (Left err) = Left err
        merge (Left err) _ = Left err
        merge (Right n) (Right m) = Right $ updateMap n m


