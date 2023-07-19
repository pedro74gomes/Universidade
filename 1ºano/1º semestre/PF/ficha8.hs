import Data.List
import Data.Char

--Ex1
data Frac = F Integer Integer

mdc :: Integer -> Integer -> Integer
mdc x y| x == y = x
       | x > y = mdc (x-y) y
       | x < y = mdc x (y-x)  

normaliza :: Frac -> Frac
normaliza (F 0 x) = F 0 1
normaliza (F x y) = F (sinal * (div (abs x) n)) (div (abs y) n)
   where n = mdc (abs x) (abs y)
         sinal = if x * y > 0 then 1 else (-1) 

instance Eq Frac where
     (F a b) == (F c d) = a * d == b * c 

instance Ord Frac where
     (F a b) <= (F c d) = a*d <= b*c
     (F a b) > (F c d) = a*d > b*c

instance Show Frac where
    show (F x 1) = show x ++ "/" ++ "1"
    show (F x y) = show x ++ "/" ++ show y

instance Num Frac where
    (F a b) + (F c d)| b == d = normaliza (F (a+c) b)
                     |otherwise = normaliza (F (a*d + b*c) (b*d))
    (F a b) * (F c d) = normaliza (F (a*c) (b*d))
    (F a b) - (F c d)| b == d = normaliza (F (a-c) b)
                     |otherwise = normaliza (F (a*d - b*c) (b*d))
    negate (F a b) = normaliza (F (-a) b)
    abs (F a b) = F (abs a) (abs b)
    signum (F a b)| a == 0 = 0
                  | a*b > 0 = 1
                  |otherwise = (-1)
    fromInteger x = F x 1 

maiorQdobro :: Frac -> [Frac] -> [Frac]
maiorQdobro f l = filter (> 2*f) l

--Ex2
data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

calcula :: Num a => Exp a -> a
calcula (Const x) = x
calcula (Simetrico x) = - calcula x
calcula (Mais x y) = (calcula x) + (calcula y)
calcula (Menos x y) = (calcula x) - (calcula y)
calcula (Mult x y) = (calcula x) * (calcula y)

infixa :: Show a => Exp a -> String
infixa (Const x) = show x
infixa (Simetrico x) = "(-"++(infixa x)++")"
infixa (Mais x y) = "("++(infixa x) ++ " + " ++ (infixa y)++")"
infixa (Menos x y) = "("++(infixa x) ++ " - " ++ (infixa y)++")"
infixa (Mult x y) = "("++(infixa x) ++ " * " ++ (infixa y)++")"


instance Show a => Show (Exp a) where
    show (Const x) = show x
    show (Mais x y) = "(" ++ show x ++ "+" ++ show y ++ ")"
    show (Simetrico x) = "(-" ++ show x ++ ")"
    show (Menos x y) = "(" ++ show x ++ "-" ++ show y ++ ")"
    show (Mult x y) = "(" ++ show x ++ "*" ++ show y ++ ")"

instance (Num a, Eq a) => Eq (Exp a) where
    x == y = calcula x == calcula y

instance (Num a, Eq a) => Num (Exp a) where
   x + y = Const (calcula x + calcula y)
   x - y = Const (calcula x - calcula y)
   x * y = Const (calcula x * calcula y)
   negate x = Const (negate (calcula x))
   abs x = Const (abs (calcula x))
   signum x = Const (signum (calcula x))
   fromInteger x = Const (fromInteger x)

--Ex3    
data Movimento = Credito Float | Debito Float
data Data = D Int Int Int deriving Eq 
data Extracto = Ext Float [(Data, String, Movimento)]

instance Ord Data where
   compare (D d m a) (D di me an)| a < an || a == an && m < me || a == an && m == me && d < di = LT
                                 | a == an && m == me && d == di = EQ
                                 |otherwise = GT

instance Show Data where
   show (D d m a) = show d ++"/" ++ show m ++ "/" ++ show a

ordena :: Extracto -> Extracto
ordena (Ext x l) = (Ext x lf)
   where lf = sortOn (\(d,_,_) -> d) l 

instance Show Extracto where
   show (Ext n l) = "Saldo anterior:" ++ show n ++
                    "\n-----------------------------------" ++
                    "\nData     Descricao  Credito  Debito" ++
                    "\n-----------------------------------" ++
                    concatMap (\(dat,str,mov) -> show dat ++ replicate (11 - (length (show dat))) ' ' ++ map (toUpper) str ++ "    \n") l ++
                    "\nSaldo actual: " ++ show (saldo (Ext n l))

saldo :: Extracto -> Float
saldo (Ext x lm) = foldl (\acc (_,_,mov) -> case mov of Credito n -> (acc + n)
                                                        Debito n -> (acc - n)) x lm















