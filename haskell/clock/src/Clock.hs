module Clock (addDelta, fromHourMin, toString) where

import Text.Printf

type Clock = Int

minutesInDay :: Int
minutesInDay = 24 * 60

fromHourMin :: Int -> Int -> Clock
fromHourMin h m = mod (h * 60 + m) minutesInDay

toString :: Clock -> String
toString clock = printf "%.02d:%.02d" hs ms
    where
        hs = div clock 60
        ms = mod clock 60 


addDelta :: Int -> Int -> Clock -> Clock
addDelta h m clock = n
    where
        delta = h * 60 + m
        n = mod (clock + delta) minutesInDay

