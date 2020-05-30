-- type is creating a type alias
type Scale = Double

doubleScale:: Scale -> Scale
doubleScale n = 2*n

{- creating a data type -}
data Coordinate t = Zero | Coord1 t | Coord2 t t | Coord3 t t t deriving (Show)

instance (Floating t, Eq t) => Eq (Coordinate t) where
      c1 == c2  = distance c1 c2 == 0


{- helper methods to access the different parts of a Coordinate -}
getx Zero                = 0
getx (Coord1 a)          = a
getx (Coord2 a b)        = a
getx (Coord3 a b c)      = a

gety Zero                = 0
gety (Coord1 a)          = 0
gety (Coord2 a b)        = b
gety (Coord3 a b c)      = b

getz Zero                = 0
getz (Coord1 a)          = 0
getz (Coord2 a b)        = 0
getz (Coord3 a b c)      = c

{- distance funtion: computes the distance between two points -}
diffsquared a b dim = ((dim a - dim b) * (dim a - dim b))
distance a b = sqrt((diffsquared a b getx) + (diffsquared a b gety) + (diffsquared a b getz))

{- distance function, again, but as an infix function -}
(##) a b = distance a b

{- I want a function that will sum two coordinates (pairwise sum each individual
   value) If you sum two coordinates with different constructors, 
   the result should be the wider of the two 
   
   (Coord1 2.0) -|- (Coord2 3.0 4.0)   =>   (Coord2 5.0 4.0) -}

(-|-) Zero Zero                     = Zero
(-|-) (Coord3 x y z) a              = Coord3 (x + getx a) (y + gety a) (z + getz a)
(-|-) a (Coord3 x y z)              = Coord3 (x + getx a) (y + gety a) (z + getz a)
(-|-) (Coord2 x y) a                = Coord2 (x + getx a) (y + gety a)
(-|-) a (Coord2 x y)                = Coord2 (x + getx a) (y + gety a)
(-|-) a b                           = Coord1 (getx a + getx b)
