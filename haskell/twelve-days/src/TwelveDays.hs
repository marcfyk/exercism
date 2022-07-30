module TwelveDays (recite) where

recite :: Int -> Int -> [String]
recite start stop = map line [start..stop]
    where line index = "On the " 
            ++ (nDays !! (index - 1))
            ++ " day of Christmas my true love gave to me: "
            ++ (concat . reverse . take index) nItems

nDays :: [String]
nDays = [
    "first", 
    "second", 
    "third", 
    "fourth", 
    "fifth", 
    "sixth" , 
    "seventh", 
    "eighth", 
    "ninth", 
    "tenth", 
    "eleventh", 
    "twelfth"]

nItems :: [String]
nItems = [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves, and ",
    "three French Hens, ",
    "four Calling Birds, ",
    "five Gold Rings, ",
    "six Geese-a-Laying, ",
    "seven Swans-a-Swimming, ",
    "eight Maids-a-Milking, ",
    "nine Ladies Dancing, ",
    "ten Lords-a-Leaping, ",
    "eleven Pipers Piping, ",
    "twelve Drummers Drumming, "]
