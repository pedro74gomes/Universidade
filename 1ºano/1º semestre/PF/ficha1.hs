--Exercício 1
perimetro :: Float -> Float
perimetro r = pi*r^2  

dist :: (Float,Float) -> (Float,Float) -> Float
dist (x,y) (m,n) = sqrt((m-x)^2 + (n-y)^2) 

primUlt :: [Int] -> (Int,Int)
primUlt a = (head a, last a)

--Exercício 2
nRaizes :: Double -> Double -> Double -> Int
nRaizes a b c | d < 0 = 0
              | d == 0 = 1
              | otherwise = 2
 where d = (b^2 - 4*a*c)

raiz :: Double -> Double -> Double -> [Double]
raiz a b c |d<0 = []
             |d == 0 = [(-b)/(2*a)]
             |otherwise = [x,y]

 where d = (b^2 - 4*a*c)
       x = (-b + sqrt d)/(2*a)
       y = (-b - sqrt d)/(2*a)

--Exercício 3
type Hora = (Int,Int)

valida :: Hora -> Bool
valida (h,m)| 0 <= h && h < 24 && 0 <= m && m < 60 = True
            |otherwise = False

compara :: Hora -> Hora -> Bool
compara (h,m) (x,y)| h > x = True
                   | h == x && m > y = True
                   |otherwise = False

converte1 :: Hora -> Int
converte1 (h,m) = h*60 + m

converte2 :: Int -> Hora
converte2 m = (div m 60, mod m 60)

diferenca :: Hora -> Hora -> Int
diferenca (h,m) (x,y) = converte1 (h-x,m-y)

adiciona :: Hora -> Int -> Hora
adiciona h m = converte2 (converte1 h + m)

--Exercício 4
data Hora1 = H Int Int deriving (Show,Eq)

valida1 :: Hora1 -> Bool
valida1 (H h m)| 0 <= h && h < 24 && 0 <= m && m < 60 = True
               |otherwise = False

--

--Exercício 5
data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

next :: Semaforo -> Semaforo
next e | e == Verde = Amarelo
       | e == Amarelo = Vermelho
       |otherwise = Verde

stop :: Semaforo -> Bool 
stop e | e == Vermelho = True
       |otherwise = False

safe :: Semaforo -> Semaforo -> Bool
safe e1 e2 | (e1 == Verde || e1 == Amarelo) && e2 == Vermelho = True
           | (e2 == Verde || e2 == Amarelo) && e1 == Vermelho = True
           | e1 == Vermelho && e2 == Vermelho = True
           |otherwise = False 

--Exercício 6
data Ponto = Cartesiano Double Double | Polar Double Double
             deriving (Show,Eq)

posx :: Ponto -> Double
posx (Cartesiano x y) = x

posy :: Ponto -> Double
posy (Cartesiano x y) = y

raio :: Ponto -> Double
raio (Polar d a) = d

angulo :: Ponto -> Double
angulo (Polar d a) = a

dist1 :: Ponto -> Ponto -> Double
dist1 (Cartesiano x y) (Cartesiano a b) = sqrt((a-x)^2+(b-y)^2)
dist1 (Polar d a) (Polar x y) = x-d

--Exercício 7
data Figura = Circulo Ponto Double
            | Retangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
            deriving (Show,Eq)

poligono :: Figura -> Bool
poligono (Circulo c r) | r > 0 = True
                       |otherwise = False
poligono (Retangulo x y) | x == y = False
                         |otherwise = True
poligono (Triangulo x y z)| x == y || x == z || y == z = False
                          |otherwise = True

vertices :: Figura -> [Ponto]
vertices (Circulo c r) = []
vertices (Retangulo x y) = [x, y]
vertices (Triangulo x y z) = [x, y, z]

area :: Figura -> Double
area (Triangulo p1 p2 p3) = let a = dist1 p1 p2
                                b = dist1 p2 p3
                                c = dist1 p3 p1
                                s = (a+b+c) / 2 -- semi-perimetro
                            in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron
area (Retangulo p1 p2) = let a = dist1 p1 (Cartesiano (posy p1) (posx p2))
                             b = dist1 p2 (Cartesiano (posy p1) (posx p2))
                         in (a * b)
area (Circulo c r) = (pi * r)^2

