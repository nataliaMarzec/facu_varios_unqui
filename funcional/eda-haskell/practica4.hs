-- ej 1

--losQuePertenecen :: Eq a => [a] -> Conjunto a -> [a]
--Dados una lista y un conjunto, devuelve una lista con todos los ele-
--mentos que pertenecen al conjunto

losQuePertenecen :: Eq a => [a]-> Conjunto a -> [a]
losQuePertenecen [] set = []
losQuePertenecen (x:xs) set = if perteneceC x set
                              then x : (losQuePertenecen xs set)
                              else losQuePertenecen xs set

-- sinrepetidos :: [a] -> [a]
--Quita todos los elementos repetidos de la lista dada utilizando un
--conjunto como estructura auxiliar 

sinrepetidos :: [a] -> [a]


