
data Conjunto a = MkSet [a] Int deriving Show

-- Crea un conjunto vacío.
vacioC :: Conjunto a
vacioC = MkSet [] 0

-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
agregarC x (MkSet xs c) = if (perteneceC x (MkSet xs c)) 
                    then (MkSet xs c) 
                    else MkSet (x:xs) (c+1)

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
borrarC x (MkSet xs c) = if (perteneceC x (MkSet xs c)) 
                    then MkSet (borrar' x xs) (c-1)
                    else MkSet xs c

-- Función auxiliar, borra un elemento de una lista.
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
listaC (MkSet xs c) = xs

-- Devuelve el máximo elemento en un conjunto.
maximoC :: Ord a => Conjunto a -> a
maximoC (MkSet [x] 1) = x

-- Versión 1
--maximoC (MkSet (x:xs) n) = if x > y then x else y
--                            where y = maximoC (MkSet xs (n-1))

-- Versión 2
maximoC (MkSet (x:y:xs) n) = if x > y
                            then maximoC (MkSet (x:xs) (n-1))
                            else maximoC (MkSet (y:xs) (n-1))
