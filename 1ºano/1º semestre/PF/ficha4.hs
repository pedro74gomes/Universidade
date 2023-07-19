--Ex1
import Data.Char  (isDigit, isAlpha)

digitAlpha :: String -> (String,String)
digitAlpha = foldr (\s (a,b) -> if (isDigit s)
                                then ((s:a), b)
                                else if (isAlpha s)
                                     then (a, (s:b))
                                     else (a, b)) ("","")

--Ex2
nzp :: [Int] -> (Int,Int,Int)
nzp = foldr (\n (a,b,c) -> if n < 0
                           then (a+1,b,c)
                           else if n == 0
                           then (a,b+1,c)
                           else (a,b,c+1)) (0,0,0) 

--Ex3
divMod' :: Integral a => a -> a -> (a, a)
divMod' x y = aux 0 x y
  where aux acc x y | x >= y = aux (acc+1) (x-y) y
                    | otherwise = (acc, x) 

--Ex4
fromDigits :: [Int] -> Int
fromDigits = foldl (\acc x -> x + 10 * acc) 0

--Ex5
inits' :: [a] -> [[a]] 
inits' [] = []
inits' [x] = [[],[x]]
inits' l = inits' (inite l) ++ [l]

inite :: [a] -> [a]
inite [] = []
inite [x] = []
inite (h:t) = h:inite t 

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit (h:t)| h > 0 = aux h h t
                | otherwise = aux 0 h t
  where aux m acc [] = m
        aux m acc (h:t)| acc + h > m = aux (acc+h) (acc+h) t
                       | otherwise = aux m (acc+h) t

--Ex6
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fibo 0 1 2 n
  where
    fibo acc1 acc2 n alvo | n == alvo = acc1 + acc2
                          | otherwise = fibo acc2 (acc1 + acc2) (n + 1) alvo

--Ex7
