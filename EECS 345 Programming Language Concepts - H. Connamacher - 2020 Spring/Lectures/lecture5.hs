{- Monads are a type where a value is wrapped in a "context" to 
   give information about the value.  Examples are "promises" in web coding,
   Java's Optional -}
data RedBlack t = Red t | Black t

{- our "monad" example, a value -}
data Value t = Value t | NoValue deriving (Show)

{- We need two basic functions, return and bind -}

myreturn:: t -> Value t
myreturn x = Value x

mybind:: Value t -> (t -> Value s) -> Value s 
mybind (Value x) f = f x
mybind NoValue _   = NoValue

{- Let's create some math operations on the monad -}
(+++) vx vy = mybind vx (\x -> mybind vy (\y -> myreturn (x + y))) 
(~~)  vx vy = vx `mybind` (\x -> vy `mybind` (\y -> myreturn (x - y)))
(//)  vx vy = vx `mybind` (\x -> vy `mybind` (\y -> if y == 0 then NoValue else myreturn (x / y)))


{- Haskell has monads: Maybe, IO, list 

   data Maybe t = Just t | Nothing
   
   return function is return
   the bind function is >>= 
-}

(++++) mx my = mx >>= (\x -> my >>= (\y -> return (x + y))) 
(~~~) mx my = do
    x <- mx
    y <- my
    return (x - y)
{- division (///) and square root (msqrt) using the Maybe monad -}
msqrt mx = mx >>= (\x -> if x < 0 then Nothing else return (sqrt x))

(///) mx my = do
    x <- mx
    y <- my
    if y == 0 then Nothing else return (x / y)

{- mapply takes two monads mx my and a function f, I want to apply "mx `f` my" -}
myapply mx f my = do
    x <- mx
    y <- my
    return (f x y)