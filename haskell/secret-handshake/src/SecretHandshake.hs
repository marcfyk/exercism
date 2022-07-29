module SecretHandshake (handshake) where

import Data.Bits

handshake :: Int -> [String]
handshake n
    | n .&. 16 /= 0 = reverse result
    | otherwise = result
    where
        result = map snd 
            $ filter ((/=0) . (n .&.) . fst)
            $ zip (map (2^) [(0::Int)..]) ["wink", "double blink", "close your eyes", "jump"]

