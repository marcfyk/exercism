module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

data BST a = BST a (BST a) (BST a) | Nil  deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Nil = Nothing 
bstLeft (BST _ left _) = Just left

bstRight :: BST a -> Maybe (BST a)
bstRight Nil = Nothing
bstRight (BST _ _ right) = Just right

bstValue :: BST a -> Maybe a
bstValue Nil = Nothing
bstValue (BST value _ _) = Just value

empty :: BST a
empty = Nil

fromList :: Ord a => [a] -> BST a
fromList = foldl (flip insert) empty

insert :: Ord a => a -> BST a -> BST a
insert x Nil = BST x Nil Nil
insert x (BST value left right)
    | x < value = BST value (insert x left) right
    | x > value = BST value left (insert x right)
    | otherwise = BST value (BST value left Nil) right
        

singleton :: a -> BST a
singleton x = BST x Nil Nil

toList :: BST a -> [a]
toList Nil = []
toList (BST value left right) = toList left ++ [value] ++ toList right
