import Data.Char

islower :: Char -> Bool
islower c| (ord c) >= 97 && (ord c) <= 122 = True
         |otherwise = False  

isdigit :: Char -> Bool
isdigit c| (ord c) >= 48 && (ord c) <= 57 = True
         |otherwise = False

--Ex 4
type Polinomio = [Monomio]
type Monomio = (Float,Int)

conta :: Int -> Polinomio -> Int
conta n [] = 0
conta n ((c,e):t)| n == e = 1 + conta n t
                 | otherwise = conta n t 

selgrau :: Int -> Polinomio -> Polinomio
selgrau n [] = []
selgrau n ((c,e):t)| n == e = (c,e):selgrau n t
                   | otherwise = selgrau n t