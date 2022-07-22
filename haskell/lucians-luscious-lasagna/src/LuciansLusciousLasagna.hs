module LuciansLusciousLasagna (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes) where

expectedMinutesInOven :: Integer
expectedMinutesInOven = 40

preparationTimeInMinutes :: Integer -> Integer
preparationTimeInMinutes layers = layers * 2

elapsedTimeInMinutes :: Integer -> Integer -> Integer
elapsedTimeInMinutes layers inOven = inOven + preparationTimeInMinutes layers
