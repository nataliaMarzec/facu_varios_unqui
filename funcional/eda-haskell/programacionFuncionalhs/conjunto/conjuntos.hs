data Conjunto a = MKSet [a] Int deriving (Show,Eq)

vacioC :: Conjunto a
vacioC = MKSet [] 0

-- conjunto sin repetidos, sin orden 
--(Mkt n left right.
-- perteneceC x (Mkset xs n))

perteneceC :: Eq a => a -> Conjunto a -> Bool
perteneceC a (MKSet [] n) = False
perteneceC a (MKSet (x:xs) n) = if(a==x)
                                then True
                                else perteneceC a (MKSet xs (n-1))
                                --(a==x)||perteneceC a (MKSet xs (n-1))

--Dados un elemento y un conjunto, agrega el elemento al conjunto
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
agregarC a (MKSet [] n) = MKSet [a] (n+1)
agregarC a (MKSet (x:xs) n) = if  perteneceC a (MKSet xs n)
                              then (MKSet xs n)
                              else (MKSet (x:xs)(n+1))

--Devuelve la cantidad de elementos distintos de un conjunto
cantidadC :: Eq a => Conjunto a -> Int
cantidadC (MKSet [] n)= 0
cantidadC (MKSet (x:xs) n)= n 

--borrarC
borrarC :: Eq a => a -> Conjunto a -> Conjunto a
borrarC a (MKSet [] n) = MKSet [a] (n-1)
borrarC a (MKSet (x:xs) n) = if perteneceC a (MKSet xs n)
                             then (MKSet) xs n-1
                             else (MKSet (x:xs)(n-1))---ver borrar pablo

--Dados dos conjuntos devuelve un conjunto con todos los elementos de
--ambos conjuntos 
--version 1
unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unionC set1 set2 = unionC' (listaC set1) ++ (listaC set2)

unionC'' :: [a] -> Conjunto a -> conjunto a  
unionC''[] set = set
unionC'' (x:xs) set = unionC'' xs (agregarC x set)

unionC' :: [a] -> conjunto a 
unionC' xs= unionC'' xs vacioC

--version 2
unionC :: conjunto a -> conjunto a -> conjunto a 
unionC (MKSet [] 0) set2 = set2
unionC (MKSet (x:xs) n) set2 = unionC (MKSet xs (n-1))(agregarC x set2)

--listaC
listaC :: Eq a ->conjunto a -> [a]
listaC (MKSet xs n) = xs


















                            








                 





                        








