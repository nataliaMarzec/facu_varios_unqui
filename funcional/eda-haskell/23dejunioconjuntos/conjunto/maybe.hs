data Maybes a = Justs a | Nothings deriving Show
--1. Defina las siguientes operaciones parciales y las precondiciones necesarias para poder utilizarlas.
--a) init :: [a] -> [a]
--Dada una lista quita su ´ultimo elemento.
mInit :: [a] -> Maybe [a]
mInit [] = Nothing
mInit [a] = Just []
mInit xs =Just (mInit xs) 

init' :: [a] -> [a] --lo que quita el ultimo elemento es el caso base
init' [a] = []
init' (x:xs) = x : init' xs
--mInit xs = Just (init xs) USA EL INIT DE HASKELL

--b) last :: [a] -> a
--Dada una lista, devuelve su ´ultimo elemento.
--last :: [a] -> a

mLast :: [a] -> Maybe a 
mLast [] = Nothing
mLast [a] = Just a
mLast xs = mLast xs --o ver mLast (x:xs) = last' xs

last' :: [a] -> a
last' [x] = x 
last' (x:xs) = last' xs 



--c) indiceDe :: Eq a => a -> [a] -> Int
--Dado un elemento y una lista devuelve la posici´on de la lista en la que se encuentra
--dicho elemento.
indiceDe' :: Eq a => a -> [a] -> Int
indiceDe' (y:ys) x = if x == y
                     then 0
                     else 1 + (indiceDe' x ys)

indiceDe :: Eq a => [a] -> a -> Maybes Int
indiceDe [] y = Nothings
indiceDe (y:ys) = if x == y then Just 0 else
                            case rst of Nothing -> Nothing
                            Just v -> Just (v+1) 
                            where rst = indiceDe x ys 


--d) valorParaClave :: Eq k => [(k,v)] -> k -> v
--Dada una lista de pares (clave, valor) y una clave devuelve el valor asociado a la clave.
valorParaClave' :: Eq k => [(k,v)] -> k ->v 
valorParaClave' ((k1,v1):xs) x = if x == k1 then v1 else valorParaClave' xs x

-- claveBuscada es mi x
valorParaClave :: Eq k -> [(k,v)] -> k -> Maybes v 
valorParaClave [] claveBuscada = Nothings
valorParaClave ((clave, valor):xs) claveBuscada = if claveBuscada == clave      
                                                  then Justs valor 
                                                  else valorParaClave xs claveBuscada

--e) maximum :: Ord a => [a] -> a
--Dada una lista de elementos devuelve el m´aximo.
maximum :: Ord a => [a] -> Maybes a 
maximum [] = Nothings
maximum [x] = Just x 
maximum (x:xs) = Just (maximun (x:xs))

maximun' :: Ord a => [a] -> a 
maximun' [x] = x 
maximum' (x:xs) = if x > y then x else y where y = maximun' xs

--f ) minT :: Ord a => Tree a -> a
--Dado un ´arbol devuelve su elemento m´ınimo
minT :: Ord a => Tree a -> a 