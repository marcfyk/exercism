module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

data Robot = Robot Bearing Integer Integer deriving Show

bearing :: Robot -> Bearing
bearing (Robot b _ _) = b

coordinates :: Robot -> (Integer, Integer)
coordinates (Robot _ x y) = (x, y)

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction (x, y) = Robot direction x y

move :: Robot -> String -> Robot
move = foldl command

command :: Robot -> Char -> Robot
command (Robot b x y) 'R' = Robot (turnRight b) x y
command (Robot b x y) 'L' = Robot (turnLeft b) x y
command (Robot North x y) 'A' = Robot North x (y+1)
command (Robot East x y) 'A' = Robot East (x+1) y
command (Robot South x y) 'A' = Robot South x (y-1)
command (Robot West x y) 'A' = Robot West (x-1) y
command r c = error (show r ++ show c)

turnRight :: Bearing -> Bearing
turnRight b = (head . tail . dropWhile (/=b) . cycle) [North, East, South, West]
turnLeft :: Bearing -> Bearing
turnLeft b = (head . tail . dropWhile (/=b) . cycle) [North, West, South, East]
