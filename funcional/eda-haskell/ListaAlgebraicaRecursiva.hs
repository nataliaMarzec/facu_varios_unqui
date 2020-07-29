-- kvamos a definir un nuevo tipo de datos que represente a una lista
--la definicion que conocemos de lista es:
-- * una lista vacia
-- * un primer elemento seguido de una lista
--
--

--el tipo de datos lo llamaremos lista
-- como puede ser una lista de cosas, le pasamos una variable de tipo.
--la opcion de lista vacia la representamos con el constructor Vacia.
--la opcion recursiva la representamos con el constructor MKL

data Lista a= Vacia | MKL a (Lista a) deriving Show

--Funcion armarLista
--Recibe una lista haskell posta, y arma una lista de las nuestras
--
armarLista :: [a] -> Lista a 
armarLista [] = Vacia
armarLista (x:xs) = MKL x (armarLista xs)

--longitud
longitud :: Lista a -> Int
longitud Vacia = 0
longitud (MKL x xs) = 1 + (longitud xs)


