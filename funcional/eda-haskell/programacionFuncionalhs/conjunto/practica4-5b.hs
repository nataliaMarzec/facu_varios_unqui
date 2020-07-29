
data Conjunto a = ESet barra MkSet [a] Int a deriving Show -- se definio asi por el maximo

-- Crea un conjunto vacío.
vacioC :: Conjunto a
vacioC = ESet

-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
agregarC x ESet = MkSet [x] 1 x
agregarC x (MkSet xs n mx) =  if (perteneceC x (MkSet xs n mx) 
                                  then (MkSet xs n mx) 
                                  else MkSet (x:xs) (n+1) (max x mx)
 --devuelve el maximo
maximoC (MkSet xs n mx)= mx   -- (ver maximo 5.1 y maximo 5.2 abajo)                             

-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
perteneceC :: Eq a => a -> Conjunto a -> Bool
perteneceC x (MkSet xs c) = pertenece' x xs

pertenece' :: Eq a => a -> [a] -> Bool
pertenece' x [] = False
pertenece' x (y:ys) = (x == y) || (pertenece' x ys)

-- Devuelve la cantidad de elementos distintos de un conjunto.
cantidadC :: Eq a => Conjunto a -> Int
cantidadC (MkSet xs c) = c

-- Borrar.
borrarC :: Eq a => a -> Conjunto a -> Conjunto a
borrarC x ESet = 
borrar x (MkSet xs n x) = MkSet (borrar' x xs)(n-1)--machea si es el x es igual al maximo entonces hay que calcular el nuevo maximo
borrarC x (MkSet xs n mx) = if perteneceC x (MkSet xs n mx) 
                            then MkSet (borrar' x xs) (n-1) mx
                            else MkSet xs n mx

borrar' :: Eq a => a -> [a] -> [a]
borrar' x [] = []
borrar' x (y:ys) = if (x == y) 
                        then ys 
                        else y:(borrar' x ys)

-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unionC (MkSet [] c) set2 = set2
unionC (MkSet (x:xs) c1) set2 = unionC (MkSet xs (c1-1)) (agregarC x set2)

-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
listaC :: Eq a => Conjunto a -> [a]
listaC Eset = []
listaC (MkSet xs c) = xs

--ejercio 5 maximo
--5.1
--1. Implementar la variante que recorre la estructura buscando el maximo
--maximoC :: Ord a => Conjunto a -> a
--maximoC (MkSet [x] 1) = x
--maximoC (MkSet (x:xs) n) = if x > y then x else y 
                             --where y = maximoC (MkSet xs (n-1))

--segunda opcion maximoC 5-1
--maximoC (MkSet [x] 1) = x
--maximoC (MkSet (x:y:xs) n)= if x > y 
                              --then maximoC (MkSet (x:xs)(n-1))
                              --else maximoC (MkSet (y:xs)(n-1)

