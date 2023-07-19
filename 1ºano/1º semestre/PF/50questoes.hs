--50 Questoes
--1  Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) enumFromTo :: Int -> Int -> [Int] 
--   que constr´oi a lista dos n´umeros inteiros compreendidos entre dois limites. 
enumFromToo :: Int -> Int -> [Int]
enumFromToo x y | x < y = [x] ++ enumFromToo (x+1) y
                |otherwise = [y]

--2 Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) enumFromThenTo :: Int -> Int -> Int -> [Int] 
--que constr´oi a lista dos n´umeros inteiros compreendidos entre dois limites e espa¸cados de um valor constante
enumFromThenToo :: Int -> Int -> Int -> [Int]
enumFromThenToo x y z | x <= z = [x] ++ enumFromThenToo (x+y-1) y z
                      |otherwise = []
                      
--3. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) (++) :: [a] -> [a] -> [a] que concatena duas listas.
(+++) :: [a] -> [a] -> [a]
(+++) [] l = l
(+++) l [] = l
(+++) (x:xs) y = x:(+++) xs y 

--4. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) (!!) :: [a] -> Int -> a que dada uma lista e um inteiro,
--calcula o elemento da lista que se encontra nessa posi¸c˜ao (assumese que o primeiro elemento se encontra na posi¸c˜ao 0).
(!!!) :: [a] -> Int -> a
(!!!) (h:t) i | i == 0 = h 
              |otherwise = (!!!) t (i-1)

--5. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) reverse :: [a] -> [a] 
--que dada uma lista calcula uma lista com os elementos dessa lista pela ordem inversa
reverse' :: [a] -> [a]
reverse' [] = []
reverse' [x] = [x]
reverse' (h:t) = reverse' t ++ [h]  

--6.Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) take :: Int -> [a] -> [a] que
--dado um inteiro n e uma lista l calcula a lista com os (no m´aximo) n primeiros elementos de l.
takee :: Int -> [a] -> [a]
takee i [] = []
takee i (h:t) | i == 0 = []
              | i == 1 = [h]
              |otherwise = [h] ++ takee (i-1) t

--7. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) drop :: Int -> [a] -> [a] que
--dado um inteiro n e uma lista l calcula a lista sem os (no m´aximo) n primeiros elementos de l.
dropp :: Int -> [a] -> [a]
dropp x [] = []
dropp x (h:t)| x == 0 = (h:t)
             | x == 1 = t
             |otherwise = dropp (x-1) t 

--8. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) zip :: [a] -> [b] -> [(a,b)]
--const´oi uma lista de pares a partir de duas listas.
zipp :: [a] -> [b] -> [(a,b)]
zipp [] l = []
zipp l [] = []
zipp (x:xs) (y:ys) = (x,y):zipp xs ys 

--9. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) replicate :: Int -> a -> [a] 
--que dado um inteiro n e um elemento x const´oi uma lista com n elementos, todos iguais a x.
replicatee :: Int -> a -> [a]
replicatee x y | x == 0 = []
               | x == 1 = [y]
               |otherwise = y:replicatee (x-1) y 

--10. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) intersperse :: a -> [a] -> [a] 
--que dado um elemento e uma lista, constr´oi uma lista em que o elemento fornecido ´e intercalado entre os elementos da lista fornecida.
interspersee :: a -> [a] -> [a] 
interspersee x [] = []
interspersee x [h] = [h]
interspersee x (h:t) = h:x:interspersee x t  

--11!. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) group :: Eq a => [a] -> [[a]] que
--agrupa elementos iguais e consecutivos de uma lista
groupp :: Eq a => [a] -> [[a]]
groupp [] = []
groupp l = (group_aux l) : groupp (dropp (length (group_aux l)) l)

group_aux :: Eq a => [a] -> [a] 
group_aux [x] = [x]
group_aux (h:x:t) | h == x = h : group_aux (x:t)
                  |otherwise = [h]

--12. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) concat :: [[a]] -> [a] 
--que concatena as listas de uma lista.
concate :: [[a]] -> [a] 
concate [[]] = []
concate [[x]] = [x]
concate (h:t) = h ++ (concate t)

--13!. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) inits :: [a] -> [[a]] 
--que calcula a lista dos prefixos de uma lista
inits' :: [a] -> [[a]] 
inits' [] = []
inits' [x] = [[],[x]]
inits' l = inits' (inite l) ++ [l]

inite :: [a] -> [a]
inite [] = []
inite [x] = []
inite (h:t) = h:inite t 

--14!. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao (pr´e-definida) tails :: [a] -> [[a]] 
--que calcula a lista dos sufixos de uma lista.
tails :: [a] -> [[a]]
tails [] = [[]]
tails [x] = [[x],[]]
tails l = [l] ++ (taile l)

taile :: [a] -> [[a]]
taile [] = []
taile [x] = [[]]
taile (h:x:t) = [x:t] ++ taile (x:t)

--15!. Defina a fun¸c˜ao heads :: [[a]] -> [a] 
--que recebe uma lista de listas e produz a lista com o primeiro elemento de cada lista.
heads :: [[a]] -> [a] 
heads [] = []
heads ([]:t) = heads t
heads ((x:xs):t) = x:heads t

--16! Defina a fun¸c˜ao total :: [[a]] -> Int 
--que recebe uma lista de listas e conta o total de elementos (de todas as listas)

total :: [[a]] -> Int
total [] = 0
total ([]:t) = total t
total [[x]] = 1
total ((x:xs):t) = 1 + total (xs:t)

--17. Defina a fun¸c˜ao fun :: [(a,b,c)] -> [(a,c)] que recebe uma lista de triplos e produz a
--lista de pares com o primeiro e o terceiro elemento de cada triplo.
fun :: [(a,b,c)] -> [(a,c)] 
fun [] = []
fun ((a,b,c):t) = (a,c):fun t

--18. Defina a fun¸c˜ao cola :: [(String,b,c)] -> String que recebe uma lista de triplos e concatena as strings que est˜ao na primeira componente dos triplos.
cola :: [(String,b,c)] -> String
cola [] = ""
cola ((s,b,c):t) = s ++ cola t

--19. Defina a fun¸c˜ao idade :: Int -> Int -> [(String,Int)] -> [String] que recebe o ano,
--a idade e uma lista de pares com o nome e o ano de nascimento de cada pessoa, e devolve a
--listas de nomes das pessoas que nesse ano atingir˜ao ou j´a ultrapassaram a idade indicada
idade :: Int -> Int -> [(String,Int)] -> [String]
idade _ _ [] = []
idade a i ((s,x):t)| a-x >= i = s:(idade a i t)
                   |otherwise = idade a i t

--20. Apresente uma defini¸c˜ao recursiva da fun¸c˜ao,powerEnumFrom :: Int -> Int -> [Int]
--que dado um valor n e um valor m constr´oi a lista [n^0, . . . , n^m−1].
powerEnumFrom :: Int -> Int -> [Int]
powerEnumFrom n m | m > 0 = powerEnumFrom n (m-1) ++ [n^(m-1)]
                  |otherwise = [] 

--21 que dado um n´umero inteiro maior ou igual a 2 determina se esse n´umero ´e primo. Para determinar se um n´umero n ´e primo, descubra se existe algum n´umero inteiro m tal que
--2 ≤ m ≤ √n e mod n m = 0. Se um tal n´umero n˜ao existir ent˜ao n ´e primo, e se existir ent˜ao n n˜ao ´e primo.



--22
isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True 
isPrefixOf _ [] = False
isPrefixOf (h:t) (x:xs) | h == x = isPrefixOf t xs
                        |otherwise = False 

--23!             
isSuffixOf :: Eq a => [a] -> [a] -> Bool
isSuffixOf [] _ = True
isSuffixOf _ [] = False
isSuffixOf x y| last x == last y = isSuffixOf (init x) (init y)
              |otherwise = False

--24
isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf (h:t) (x:xs)| h == x = isSubsequenceOf t xs
                            |otherwise = isSubsequenceOf (h:t) xs

--25!
elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices x l = elemI 0 x l

elemI :: Eq a => Int -> a -> [a] -> [Int]
elemI i a [] = []
elemI i a (h:t)| a == h = i:elemI (i+1) a t
               |otherwise = elemI (i+1) a t  

--26
nub :: Eq a => [a] -> [a]
nub [] = []
nub [x] = [x]
nub (h:t)| elem h t = nub t
         | otherwise = h:nub t  

--27
delete :: Eq a => a -> [a] -> [a]
delete _ [] = []
delete x (h:t)| x == h = t
              | otherwise = h:delete x t

--28
(\\) :: Eq a => [a] -> [a] -> [a]  
(\\) [] l = []
(\\) l [] = l
(\\) (h:t) (x:xs)| h == x = (\\) t xs
                 |otherwise = h:(\\) t (x:xs)

--29
union :: Eq a => [a] -> [a] -> [a]
union [] l = l
union l [] = l
union l (x:xs)| elem x l = union l xs
              |otherwise = union (l ++ [x]) xs

--30
intersect :: Eq a => [a] -> [a] -> [a]
intersect [] l = []
intersect l [] = []
intersect (h:t) l | elem h l = h:intersect t l
                  |otherwise = intersect t l

--31
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (h:t)| x <= h = x:h:t
              |otherwise = h:insert x t

--32
unwordss :: [String] -> String
unwordss [] = ""
unwordss [x] = x
unwordss (h:t) = h ++ " " ++ (unwordss t)              

--33
unliness :: [String] -> String
unliness [] = ""
unliness [x] = x ++ "\n"
unliness (h:t) = h ++ "\n" ++ unliness t

--34
pMaior :: Ord a => [a] -> Int
pMaior [x] = 0
pMaior (h:x:t)| h < x = 1 + pMaior (x:t)
              |otherwise = pMaior (h:t) 

--35
lookupp :: Eq a => a -> [(a,b)] -> Maybe b
lookupp a [] = Nothing
lookupp a ((x,n):t)| a == x = Just n
                  |otherwise = lookupp a t  

--36
preCrescente :: Ord a => [a] -> [a] 
preCrescente [] = []
preCrescente [x] = [x]
preCrescente (h:x:t)| h <= x = h:preCrescente(x:t)
                    | otherwise = [h]

--37!
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (h:t) = insert h (iSort t)

--38
menor :: String -> String -> Bool
menor "" _ = True
menor x y | length x <= length y = True
          |otherwise = False

--39
elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet a [] = False
elemMSet a ((x,n):t)| a == x = True
                    |otherwise = elemMSet a t

--40
converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet ((a,n):t) | n == 1 = [a] ++ converteMSet t
                       | n > 1 = [a] ++ converteMSet ((a,n-1):t)
                       | n == 0 = converteMSet t

--41
insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet a [] = [(a,1)]
insereMSet a ((x,n):t)| a == x = ((x,n+1):t)
                      |otherwise = (x,n):insereMSet a t

--43!
constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet l = constroi_aux l 1

constroi_aux :: Ord a => [a] -> Int -> [(a,Int)]
constroi_aux [x] n = [(x,n)]
constroi_aux (h:x:t) n | h == x = constroi_aux (x:t) (n+1)
                       |otherwise = (h,n):constroi_aux (x:t) 1

--45
catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes ((Nothing):t) = catMaybes t
catMaybes ((Just h):t) = h:catMaybes t
