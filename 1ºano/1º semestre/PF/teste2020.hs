import Data.List
import Data.Char
--Teste 2020
--1
--a) retorna a lista resultante de remover da primeira lista os elementos que nao pertencem a segunda.
intersectt :: Eq a => [a] -> [a] -> [a]
intersectt [] _ = []
intersectt _ [] = []
intersectt (x1:y1) l | elem x1 l = x1:intersectt y1 l
                    | otherwise = intersect y1 l

--b) calcula a lista dos sufixos de uma lista.
tailss :: [a] -> [[a]]
tailss [] = [[]]
tailss (h:t) = (h:t):tailss t

--2
type ConjInt = [Intervalo]
type Intervalo = (Int, Int)

--a) dado um conjunto, da como resultado a lista dos elementos desse conjunto.
elems :: ConjInt -> [Int]
elems [] = []
elems ((a,b) : t)
    | a == b    = a : elems t
    | otherwise = a : elems ((succ a,b) : t)

--b) recebe uma lista de inteiros, ordenada por ordem crescente e sem repeticoes, e gera um conjunto
geraconj :: [Int] -> ConjInt
geraconj [] = []
geraconj (h:t) = (h,d) : geraconj (dropWhile (<= d) t)
         where d = ultSucc (h:t)

ultSucc :: [Int] -> Int
ultSucc (h:d:t) | d == succ h = ultSucc (d:t)
                | otherwise = h

--3
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
    deriving (Show)

type Nome = String
type Agenda = [(Nome, [Contacto])]

--a)  dado um nome, um email e uma agenda, acrescenta essa informacao a agenda.
acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n e [] = [(n, [Email e])]
acrescEmail n e ((a,b):t)| n == a = ((n,[Email e]):t)
                         | otherwise = acrescEmail n e t

--b) dado um nome e uma agenda, retorna a lista dos emails associados a esse nome. 
verEmails :: Nome -> Agenda -> Maybe [String] 
verEmails n [] = Nothing
verEmails n ((a,[Email b]):t) | n == a = Just [b]
                              | otherwise = verEmails n t

--c) dada lista de contactos, retorna o par com a lista de numeros de telefone (tanto telefones fixos como telemoveis) e a lista de emails, dessa lista                       
consulta :: [Contacto] -> ([Integer],[String]) 
consulta = foldr (\x (i,s) -> case x of Email e -> (i,e:s); otherwise -> (n x:i,s)) ([],[]) 
    where n x = case x of Casa num -> num
                          Trab num -> num
                          Tlm num -> num

consultaIO :: Agenda -> IO ()
consultaIO agenda = do
    nome <- getLine
    let contactos = aux nome agenda
    putStr (concat [show x ++ "\n" | x <- contactos])

    where aux _ [] = []
          aux nome ((name,contactos):t) = if name == nome then contactos else aux nome t

--4
data RTree a = R a [RTree a] deriving (Show, Eq)
--a) dada uma destas arvores calcula todos os caminhos desde a raız ate as folhas.
paths :: RTree a -> [[a]]
paths (R a []) = [[a]]
paths (R a l) = [a:(map a paths l)]


