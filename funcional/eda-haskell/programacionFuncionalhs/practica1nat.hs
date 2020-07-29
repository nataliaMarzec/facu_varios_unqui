--Funciones basicas
--Resolver las siguientes funciones utilizando recursión explicita
--(encontrada en los modulos Prelude y Data.List, buscar definiciones y 
--ejemplos en Hoogle):

--1.id:
id' :: a -> a
id' a = a

--2-const
const' :: a -> b->a
const' a b = a

--3 fst 
fst' :: (a,b)-> a
fst' (x,y) = x

--5 swap 
swap' :: (a,b)-> (b,a)
swap' (x,y) = (y,x)

--6 head
head' :: [a] -> a
head' (x:y) = x

--7 tail 
tail':: [a] -> [a]
tail' (x:xs) = xs

--8 null
null' :: [a] -> Bool
null' [] = True
null' xs = False

--9 suma,producto :: Num a => [a] -> a
suma :: Num a => [a] -> a
suma [] = 0
suma (x:xs) = x + suma xs

producto [] = 1
producto (x:xs)= x * producto xs

--10 length 
length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length' xs

--11 elem
elem' :: Eq a => a -> [a] -> Bool
elem' e [] = False
elem' e (x:xs) = if e == x 
                 then True
                 else elem' e xs

--11 notElem
notElm :: Eq a => a -> [a] -> Bool
notElm e xs = not(elem' e xs)

--12 and,or 
and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) = x && and' xs 

orr' :: [Bool] -> Bool
orr' [] = False
orr' (x:xs) = x || orr' xs 

--13 count ¿Cuántas veces el elemento está en la lista?
count' :: Eq a => a -> [a] -> Int
count' e [] = 0
count' e (x:xs) = if e == x
                  then 1 + count' e xs
                  else count' e xs
       

--14 last  , podria verse la 3er línea como caso base?
last' :: [a] -> a 
last' [x] = x
last' (x:xs) = last' xs

--15 init
init' :: [a] -> a 
init' [x:xs:ys] = ys 
init' (x:ys) = init' ys


