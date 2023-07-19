--Ex1
data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt

calcula :: ExpInt -> Int
calcula (Const x) = x
calcula (Simetrico x) = (- calcula x)
calcula (Mais x y) = (calcula x) + (calcula y)
calcula (Menos x y) = (calcula x) - (calcula y)
calcula (Mult x y) = (calcula x) * (calcula y)

infixa :: ExpInt -> String
infixa (Const x) = show x
infixa (Simetrico x) = "(-"++(infixa x)++")"
infixa (Mais x y) = "("++(infixa x) ++ " + " ++ (infixa y)++")"
infixa (Menos x y) = "("++(infixa x) ++ " - " ++ (infixa y)++")"
infixa (Mult x y) = "("++(infixa x) ++ " * " ++ (infixa y)++")"

posfixa :: ExpInt -> String
posfixa (Const x) = show x ++ " "
posfixa (Simetrico x) = " -" ++ (posfixa x)
posfixa (Mais x y) = (posfixa x) ++ (posfixa y) ++ " +"
posfixa (Menos x y) = (posfixa x) ++ (posfixa y) ++ " -"
posfixa (Mult x y) = (posfixa x) ++ (posfixa y) ++ " *"

--Ex2
data RTree a = R a [RTree a]

rt = R 6 [R 4 [R 7 [R 1 [],
                        R 3 []],
                   R 9 []],
              R 3 [R 12 []],
              R 6 [],
              R 11 []]

soma :: Num a => RTree a -> a
soma (R a []) = a
soma (R a r) = a + sum(map (soma) r) 

altura :: RTree a -> Int 
altura (R a []) = 1
altura (R a r) = 1 + maximum(map altura r)

prune :: Int -> RTree a -> RTree a
prune 0 (R a r) = R a []
prune n (R a r) = R a (map (prune (n-1)) r)

mirror :: RTree a -> RTree a
mirror (R a r) = R a (map mirror (reverse r))

postorder :: RTree a -> [a] 
postorder (R e []) = [e]
postorder (R e r) = concatMap postorder r ++ [e]

--Ex3
data BTree a = Empty | Node a (BTree a) (BTree a)

data LTree a = Tip a | Fork (LTree a) (LTree a) deriving Show

ltree = Fork (Fork (Tip 5)
                    (Fork (Tip 6)
                          (Tip 4)))
              (Fork (Fork (Tip 3)
                          (Tip 7))
                    (Tip 5))

ltSum :: Num a => LTree a -> a
ltSum (Tip a) = a
ltSum (Fork e d) = ltSum e + ltSum d

listaLT :: LTree a -> [a]
listaLT (Tip a) = [a]
listaLT (Fork e d) = listaLT e ++ listaLT d

ltHeight :: LTree a -> Int
ltHeight (Tip a) = 0
ltHeight (Fork e d) = 1 + max (ltHeight e) (ltHeight d)

--Ex4
data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

ftree1 = No 8 (No 1 (Leaf 5)
                    (No 2 (Leaf 6)
                          (Leaf 4)))
              (No 9 (No 10 (Leaf 3)
                           (Leaf 7))
                    (Leaf 5))

splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf n) = (Empty, Tip n)
splitFTree (No a b c) = (Node a (fst (splitFTree b)) (fst (splitFTree c)), Fork (snd (splitFTree b)) (snd (splitFTree c)))

joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees (Empty) (Tip n) = Just (Leaf n)
joinTrees (Node e l r) (Fork a b) = Just (No e aux aux2)
    where Just aux = joinTrees l a
          Just aux2 = joinTrees r b
joinTrees _ _ = Nothing 