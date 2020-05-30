{- this is a comment -}

{- factorial function, 3 ways, first "standard" -}
factorial n =
    if n == 0
        then
            1
        else
            n * factorial (n - 1)

{- factorial using "lambda" -}
factorial2 =
    \n -> 
        if n == 0
            then
                1
            else
                n * factorial2 (n - 1)

{- factorial using pattern matching -}
factorial3 0 = 1
factorial3 n = n * factorial3 (n - 1)

{- myappend 3 ways -}
myappend1 l1 l2 =
    if l1 == []
        then
            l2
        else
            {- (cons (car l1) (myappend (cdr l1) l2)) -}
            (head l1) : myappend1 (tail l1) l2

{- myappend using lambda notation -}
myappend2 :: Eq a => [a] -> [a] -> [a] 
myappend2 =
    \l1 l2 ->
        if l1 == []
            then
                l2
            else
                (head l1) : myappend2 (tail l1) l2

{- myappend using patterns -}
myappend3 [] l    = l
myappend3 (h:t) l = h : myappend3 t l

{- remove all of an element from a list -}
removeall a [] = []
removeall a (h:t) = 
    if h == a
        then
            removeall a t
        else
            h : (removeall a t)

removeall2 _ [] = []
removeall2 a (h:t)
    | a == h      = removeall2 a t
    | otherwise   = h : removeall2 a t

{- replaceall :
      replaceall 1 2 [1,2,3,1,2,3]     =>  [2,2,3,2,2,3] -}
replaceall _ _ [] = []
replaceall a b (h:t) 
    | a == h       = b : replaceall a b t
    | otherwise    = h : replaceall a b t


{- myreverse : 
       myreverse [1,2,3,4]     =>   [4,3,2,1]  -}
myreverse [] = []
myreverse (h:t)  =  myappend3 (myreverse t) [h]

myreverse2 [] = []
myreverse2 (h:t) = (myreverse2 t) ++ [h]

myreverse3 [] = []
myreverse3 (h:t) = ((++) . myreverse3) t [h]

{- merge :
       merge [1,3,5,6] [2,3,7,8]   =>  [1,2,3,3,5,6,7,8]  -}




