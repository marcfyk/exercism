module LuciansLusciousLasagna (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes) where

-- TODO: define the expectedMinutesInOven constant
expectedMinutesInOven = 40

-- TODO: define the preparationTimeInMinutes function
preparationTimeInMinutes n = n * 2

-- TODO: define the elapsedTimeInMinutes function
elapsedTimeInMinutes layers minutes =
  preparationTimeInMinutes layers + minutes