module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year =
    if rem year 400 == 0 then True
    else rem year 4 == 0 && rem year 100 /= 0

