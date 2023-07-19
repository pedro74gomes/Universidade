import Data.List

--Ex1
anyy :: (a -> Bool) -> [a] -> Bool
anyy f [] = False
anyy f (h:t) = f h || anyy f t 

zipWithh :: (a->b->c) -> [a] -> [b] -> [c]
zipWithh f (h:t) (x:xs) = (f h x): zipWithh f t xs
zipWithh f _ _ = []

takeWhilee :: (a->Bool) -> [a] -> [a]
takeWhilee f [] = []
takeWhilee f (h:t)| f h = h:takeWhilee f t
                  | otherwise = []

dropWhilee :: (a->Bool) -> [a] -> [a]
dropWhilee f [] = []
dropWhilee f (h:t)| f h = dropWhilee f t
                  | otherwise = h:t

spann :: (a -> Bool) -> [a] -> ([a],[a])
spann f [] = ([],[])
spann f (h:t)| f h = (h:a, b)
             | otherwise = ([], h:t)
  where (a,b) = spann f t

deleteByy :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteByy f x [] = []
deleteByy f x (h:t)| f x h = t
                  | otherwise = h:deleteByy f x t 

sortOnn :: Ord b => (a -> b) -> [a] -> [a]
sortOnn f [] = []
sortOnn f (h:t) = insertOn f h (sortOnn f t)
           where insertOn f x [] = [x]
                 insertOn f x (h:t)| f x <= f h = x:h:t 
                                   | otherwise = h:insertOn f x t

--Ex2
type Polinomio = [Monomio]
type Monomio = (Float,Int)

selgrau :: Int -> Polinomio -> Polinomio
selgrau g [] = []
selgrau g l = filter (\(c,e) -> e == g) l

conta :: Int -> Polinomio -> Int
conta n [] = 0
conta n p = length (selgrau n p)

grau :: Polinomio -> Int 
grau [] = 0
grau p = maximum (map snd p)

deriv :: Polinomio -> Polinomio
deriv [] = []
deriv p = filter (\(c,e) -> c /= 0) (map (\(c,e) -> (c*fromIntegral e, e-1)) p)

calcula :: Float -> Polinomio -> Float
calcula x p = sum (map (\(c,e) -> (c*x)^e) p) 

simp :: Polinomio -> Polinomio
simp [] = []
simp p = filter (\(c,e) -> c /= 0) p

mult :: Monomio -> Polinomio -> Polinomio
mult m [] = []
mult (c,e) p = map (\(x,y) -> (c*x, e+y)) p

ordena :: Polinomio -> Polinomio
ordena [] = []
ordena p = sortOnn snd p

normaliza :: Polinomio -> Polinomio
normaliza p = let
                 ps = ordena p
                 pg = groupBy (\x y -> snd x == snd y) ps
                 pf = map (\l -> (sum (map fst l), snd (head l))) pg
                 in filter (\x -> fst x /= 0) pf

soma :: Polinomio -> Polinomio -> Polinomio
soma p1 p2 = normaliza (p1 ++ p2)  

produto :: Polinomio -> Polinomio -> Polinomio
produto p (h:t) = (normaliza (mult h p)) ++ (produto p t)
produto _ _ = []

equiv :: Polinomio -> Polinomio -> Bool
equiv p1 p2 = all (elemm p22) p11
         where
              p11 = normaliza p1
              p22 = normaliza p2
              elemm [] (x,y) = False
              elemm (h:t) (x,y) = (y == snd h && x == fst h) || elemm t (x,y)

--Ex3
type Mat a = [[a]]

dimOk :: Mat a -> Bool
dimOk (h:t) = all (== length h) (map length t) 
dimOk _ = True

dimMat :: Mat a -> (Int,Int)
dimMat (h:t) = (length h, length (h:t))

addMat :: Num a => Mat a -> Mat a -> Mat a
addMat = zipWithh (zipWithh (+)) 

transposee :: Mat a -> Mat a
transposee [] = []
transposee (h:t) = zipWith (:) h (transpose t)

multMat :: Num a => Mat a -> Mat a -> Mat a
multMat = zipWithh (zipWithh (*))

zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c