{- higher order function, functions that take functions as input 
   map
   filter
   foldl
   foldr
-}

{- the identity function on lists using foldr -}
iden:: [a] -> [a]
iden = foldr (:) []

{- myreverse -}
myreverse:: [a] -> [a]
myreverse = foldl (\x y -> y : x) []

{- quicksort : take the first element as the pivot, split the list, recurse on each piece -}
qsort [] = []
qsort (h:t) = qsort (filter (< h) t) ++ [h] ++ qsort (filter (>= h) t)