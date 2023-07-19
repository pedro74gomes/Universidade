data Hora = H Int Int
          deriving Show
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

--Ex1
--
valida :: Hora -> Bool
valida (H h m)| 0 <= h && h < 24 && 0 <= m && m < 60 = True
              |otherwise = False

compara :: Hora -> Hora -> Bool
compara (H h m) (H x y)| h > x = True
                       | h == x && m > y = True
                       |otherwise = False
--
etapa :: Etapa -> Bool
etapa (i,f)| valida i && valida f && compara f i = True
           | otherwise = False  

viagem :: Viagem -> Bool
viagem (e:t)| etapa e && compara (snd (head t)) (snd e) = True
            | otherwise = False  

hora :: Viagem -> (Hora,Hora)
hora (e:t) = (fst e, snd (last t))

--
converte1 :: Hora -> Int
converte1 (H h m) = h*60 + m

converte2 :: Int -> Hora
converte2 m = (H (div m 60) (mod m 60))

diferenca :: Hora -> Hora -> Int
diferenca (H h m) (H x y) = converte1 (H (h-x) (m-y))

adiciona :: Hora -> Int -> Hora
adiciona h m = converte2 (converte1 h + m)
--

tempoV :: Viagem -> Int
tempoV [] = 0
tempoV (e:t) = (diferenca (snd e) (fst e)) + tempoV t       

tempoE :: Viagem -> Int
tempoE [] = 0
tempoE [x] = 0
tempoE (e:p:t) = (diferenca (fst p) (snd e)) + tempoE (p:t)

tempoT :: Viagem -> Int
tempoT [] = 0
tempoT v = tempoV v + tempoE v

--Ex2
data Ponto = Cartesiano Double Double | Polar Double Double
             deriving (Show,Eq)

type Poligonal = [Ponto]

dist1 :: Ponto -> Ponto -> Double
dist1 (Cartesiano x y) (Cartesiano a b) = sqrt((a-x)^2+(b-y)^2)
dist1 (Polar d a) (Polar x y) = x-d

linha :: Poligonal -> Double
linha [] = 0
linha [x] = 0
linha (h:p:t) = (dist1 h p) + (linha (p:t))

fechada :: Poligonal -> Bool
fechada l| head l == last l = True
         | otherwise = False

data Figura = Circulo Ponto Double
            | Retangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
            deriving (Show,Eq)

mover :: Poligonal -> Ponto -> Poligonal
mover l p = p:l

--Ex3
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
              deriving Show

type Nome = String
type Agenda = [(Nome, [Contacto])]

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail p x [] = [(p,[Email x])]
acrescEmail p x ((n,c):t)| p == n = (n,(Email x:c)):t
                         | otherwise = (n,c):acrescEmail p x t  

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails p ((n,c):t)| p == n = Just (email c)
                     | otherwise = verEmails p t

email :: [Contacto] -> [String]
email [] = []
email ((Email e):t) = e:email t

consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs ((Casa x):t) = x: consTelefs t
consTelefs ((Trab x):t) = x: consTelefs t  
consTelefs ((Tlm x):t) = x: consTelefs t
consTelefs (_:t) = consTelefs t

casa :: Nome -> Agenda -> Maybe Integer
casa n [] = Nothing
casa p ((n,c):t)| p == n = casaTelf c
                |otherwise = casa p t

casaTelf :: [Contacto] -> Maybe Integer
casaTelf [] = Nothing
casaTelf ((Casa n):t) = Just n  

--Ex4
type Dia = Int
type Mes = Int
type Ano = Int
--type Nome = String

--data Data = D Dia Mes Ano
--          deriving Show

type TabDN = [(Nome,Data)]

procura :: Nome -> TabDN -> Maybe Data
procura n [] = Nothing
procura p ((n,d):t)| p == n = Just d
                   |otherwise = procura p t

idade :: Data -> Nome -> TabDN -> Maybe Int
idade d n [] = Nothing
idade (D d m a) p ((n,(D dn mn an)):t)| p == n = Just (a - an)
                                      | otherwise = idade (D d m a) p t 

anterior :: Data -> Data -> Bool
anterior (D d m a) (D di me an)| a < an = True
                               | a == an && m < me = True
                               | a == an && m == me && d < di = True
                               | otherwise = False

ordena :: TabDN -> TabDN
ordena (h:t) = insere h (ordena t)   

insere :: (Nome,Data) -> TabDN -> TabDN 
insere x [] = [x]
insere x (h:t)| anterior (snd x) (snd h) = x:insere h t
                  | otherwise = h:insere x t

porIdade:: Data -> TabDN -> [(Nome,Int)]
porIdade d [] = []
porIdade d ((n,dn):t) = (idad d n (ordena ((n,dn):t))):porIdade d t 

idad :: Data -> Nome -> TabDN -> (Nome,Int)   
idad (D d m a) p ((n,(D dn mn an)):t)| p == n = (n,(a - an))
                                     | otherwise = idad (D d m a) p t

--Ex5
data Movimento = Credito Float | Debito Float
               deriving Show
data Data = D Int Int Int
          deriving Show
data Extracto = Ext Float [(Data, String, Movimento)]
              deriving Show

extValor :: Extracto -> Float -> [Movimento]
extValor (Ext v []) n = []
extValor (Ext v ((d,s,Credito x):t)) n| x > n = (Credito x):extValor (Ext v t) n
                                      |otherwise = extValor (Ext v t) n
extValor (Ext v ((d,s,Debito x):t)) n| x > n = (Debito x):extValor (Ext v t) n
                                     | otherwise = extValor (Ext v t) n

filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro (Ext v []) l = []
filtro (Ext v m) [] = []
filtro (Ext v ((d,s,Credito x):t)) l| elem s l = (d,Credito x):filtro (Ext v t) l
                                       |otherwise = filtro (Ext v t) l
filtro (Ext v ((d,s,Debito x):t)) l| elem s l = (d,Debito x):filtro (Ext v t) l
                                   | otherwise = filtro (Ext v t) l

creDeb :: Extracto -> (Float,Float)
creDeb (Ext v m) = (cre m, deb m)

cre :: [(Data,String,Movimento)] -> Float
cre [] = 0
cre ((d,s,Credito m):t) = 1 + cre t
cre ((d,s,Debito m):t) = cre t 

deb :: [(Data,String,Movimento)] -> Float
deb [] = 0
deb ((d,s,Credito m):t) = cre t
deb ((d,s,Debito m):t) = 1 + cre t

saldo :: Extracto -> Float
saldo (Ext v m) = v - c + d 
      where (c,d) = creDeb (Ext v m)