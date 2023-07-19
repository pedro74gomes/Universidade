import Data.Char
import Data.List

--Ex1
(\\\):: Eq a => [a] -> [a] -> [a]
(\\\) l [] = l
(\\\) [] _ = []
(\\\) l (h:t) = (\\\) (delete h l) t

--Ex2
type MSet a = [(a,Int)]

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet x [] = []
removeMSet x ((a,b):t)| x == a = t
                      | otherwise = (a,b):removeMSet x t

calcula :: MSet a -> ([a],Int)
calcula [] = ([],0)
calcula l = sum (map (\(s,i) -> (s,i)) l) 