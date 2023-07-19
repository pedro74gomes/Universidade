
data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show
-- a1 = Node 1 (Node 5(Node 4 Empty Empty) (Node 3  (Node 2 Empty Empty) (Node 1 Empty Empty))) Empty

--1
--a calcula a altura da arvore.
altura :: BTree a -> Int
altura Empty = 0
altura (Node r e d) = 1 + (max (altura e)(altura d))

--b calcula o numero de nodos da arvore.
contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node r e d) = 1 + (contaNodos e) + (contaNodos d)

--c  calcula o numero de folhas (i.e., nodos sem descendentes) da arvore.
folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node _ Empty Empty) = 1
folhas (Node r e d) = (folhas e) + (folhas d)

--d remove de uma arvore todos os elementos a partir de uma determinada profundidade.
prune :: Int -> BTree a -> BTree a
prune 0 (Node r e d) = Empty
prune x Empty = Empty
prune x (Node r e d) = Node r (prune (x-1) e) (prune (x-1) d)

--e dado um caminho (False corresponde a esquerda e True a direita) e uma arvore, da a lista com a informacao dos nodos por onde esse caminho passa.  
path :: [Bool] -> BTree a -> [a]
path  [] _ = []
path _ Empty = []
path (h:t) (Node r e d) | h == False = r:(path t e) 
                        | otherwise = r:(path t d)

--f  da a arvore simetrica.
mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node r e d) = Node r (mirror d) (mirror e)

--g generaliza a funcao zipWith para arvores binarias.
zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT f Empty (Node r1 e1 d1) = Empty
zipWithBT f (Node r e d) Empty = Empty
zipWithBT f (Node r e d) (Node r1 e1 d1) = Node (f r r1) (zipWithBT f e e1) (zipWithBT f d d1)

--h generaliza a funcao unzip (neste caso de triplos) para arvores binarias.
unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (x,y,z) e d) = let (e1,e2,e3) = unzipBT e
                                 (d1,d2,d3) = unzipBT d
                             in ((Node x e1 d1), (Node y e2 d2), (Node z e3 d3))

--2
--a calcula o menor elemento de uma arvore binaria de procura nao vazia.
minimo :: Ord a => BTree a -> a
minimo (Node r Empty d) = r
minimo (Node r e d) = minimo e

--b remove o menor elemento de uma arvore binaria de procura nao vazia.
semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node r Empty d) = d
semMinimo (Node r e d) = Node r (semMinimo e) d

--c  calcula,com uma unica travessia da arvore o resultado das duas funcoes anteriores.
minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node r Empty d) = (r,d)
minSmin (Node r e d) = let (m,e1) = minSmin e
                       in (m,Node m e1 d)

--d  remove um elemento de uma arvore binaria de procura, usando a funcao anterior.
remove :: Ord a => a -> BTree a -> BTree a 
remove x (Node r Empty d)| x == r = d
                         | otherwise = remove x d
remove x (Node r e d)| x == fst (minSmin (Node r e d)) = snd (minSmin (Node r e d))
                     | otherwise = remove x (snd (minSmin (Node r e d)))  

--Ex3
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                   | Rep
                   | Faltou
     deriving Show
type Turma = BTree Aluno -- ´arvore bin´aria de procura (ordenada por n´umero)

t :: BTree Aluno
t = Node (2,"Joao",ORD,Aprov 15) (Node (1,"Tiago",TE,Aprov 19) Empty Empty) (Node (3,"Diogo",MEL,Rep) Empty (Node (4,"Manel",TE,Faltou) Empty Empty))

inscNum :: Numero -> Turma -> Bool
inscNum n Empty = False 
inscNum n (Node (num,_,_,_) e d)| n < num = inscNum n e
                                | n == num = True
                                |otherwise = inscNum n d

inscNome :: Nome -> Turma -> Bool
inscNome n Empty = False 
inscNome n (Node (_,nome,_,_) e d) = n == nome || inscNome n e || inscNome n d

trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (num,nome,reg,_) e d) |regime reg = trabEst e ++ [(num,nome)] ++ trabEst d 
                                    |otherwise = trabEst e ++ trabEst d 
    where regime :: Regime -> Bool
          regime TE = True
          regime _ = False

nota :: Numero -> Turma -> Maybe Classificacao
nota n Empty = Nothing
nota n (Node (num,_,_,c) e d)| n < num = nota n e
                             | n == num = Just c
                             |otherwise = nota n d


