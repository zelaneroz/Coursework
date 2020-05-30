{- haskell cps -}

{- factorial-cps -}
factorial_cps n return =
    if n == 0
        then
            return 1
        else
            factorial_cps (n - 1) (\v -> return (n * v))

{- append-cps -}
append_cps [] l return = return l
append_cps (h:t) l return = append_cps t l (\v -> return (h:v))
        
{- split-cps: takes a list and returns two lists, dividing the elements between them -}
split_cps [] return    = return [] []
split_cps (h:t) return = split_cps t (\v1 v2 -> return v2 (h:v1))

{- merge-cps -}
merge_cps [] l return = return l
merge_cps l [] return = return l
merge_cps (h1:t1) (h2:t2) return
    | h1 < h2     = merge_cps t1 (h2:t2) (\v -> return (h1:v))
    | otherwise   = merge_cps t2 (h1:t1) (\v -> return (h2:v))

{- mergesort -}
mergesort [] return = return []
mergesort [a] return = return [a]
mergesort l return  = split_cps l (\l1 l2 -> mergesort l1 
                 (\s1 -> mergesort l2 (\s2 -> merge_cps s1 s2 return)))



{- defining types in Haskell -}

{- create a "coordinate" type, a coordinate can be 2 doubles or 3 doubles,
    the type is called "Coordinate", "Coord3D" and "Coord2D" are separate constructors
    for creating instances of this type -}

data Coordinate = Coord3D Double Double Double | Coord2D Double Double deriving (Show)

{- distance returns the distance between two coordinates -}
distance (Coord2D a b) (Coord2D c d) = sqrt((a - c) * (a - c) + (b-d) * (b-d))
-- distance (Coord3D a b c) (Coord3D a b c) = fill in the rest

