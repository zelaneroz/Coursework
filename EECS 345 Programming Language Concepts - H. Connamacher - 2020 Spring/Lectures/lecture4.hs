{- binary tree.  A binary tree is leaf, (empty), a node with 2 children -}
data BinaryTree t = Empty | Leaf t | InnerNode t (BinaryTree t) (BinaryTree t) deriving (Show, Eq)

{- inorder conversion of the tree to a list -}
inorder Empty             = []
inorder (Leaf a)          = [a]
inorder (InnerNode a l r) = (inorder l) ++ a : (inorder r)   

{- pre-order conversion of the tree to a list (node, then left child, then right child) -}
preorder Empty             = []
preorder (Leaf a)          = [a]
preorder (InnerNode a l r) = a : (preorder l) ++ (preorder r)

{- insert an element into the tree in order -}
insert e Empty             =  Leaf e
insert e (Leaf a)     
    | e < a                =  InnerNode a (Leaf e) Empty         
    | otherwise            =  InnerNode a Empty (Leaf e)
insert e (InnerNode a l r)
    | e < a                =  InnerNode a (insert e l) r
    | otherwise            =  InnerNode a l (insert e r)

{- applytotree takes a function (of 1 input) and applies the function to all values stored in the tree
   Ex:  apply a function to double the value of each element in the tree -}
applytotree f Empty      = Empty
applytotree f (Leaf a)   = Leaf (f a)
applytotree f (InnerNode a l r)  = InnerNode (f a) (applytotree f l) (applytotree f r)

{- foldinorder, foldpostorder :
    takes a binary function and a value, it applies the function to a node value with the second value, the result is passed to the next node in the tree.
    for fold, use the input value as the second operand of the function -}
{- ex: use + as a function with 0 as the value, this with the fold function will sum all the values in the tree -}

foldinorder f v Empty  = v
foldinorder f v (Leaf a) = f a v
foldinorder f v (InnerNode a l r) = foldinorder f (f a (foldinorder f v l)) r

{- we can define inorder very simply:
    inorder t = foldpostorder (:) [] t
    -}