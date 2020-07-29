{-ejercicio2.1.7
todoVerdad :: [Bool]-> Bool
todoVerdad [] = False
todoVerdad [x] = x
todoVerdad (x:xs) = x && todoVerdad xs

 ejercicio2.1.8
algunaVerdad :: [Bool] -> Bool
algunaVerdad [] = False
algunaVerdad [x] = x 
algunaVerdad (x:xs) = x || algunaVerdad xs

 ejercicio2.1.9
pertenece :: Eq a => a -> [a] -> Bool
pertenece e [] = False
pertenece e (x:xs) = if( e == x)
                     then True
                     else pertenece  e (xs) 


 ejercicio2.1.10
apariciones :: Eq a => a -> [a] -> Int
apariciones e [] = 0
apariciones e (x:xs) = if (e == x)
                       then 1 + apariciones e (xs)
                       else apariciones e (xs)

 ejercicio 2.1.11
filtrarMenoresA :: Int -> [Int] -> [Int]
filtrarMenoresA n [] = []
filtrarMenoresA n (x:xs) = if (n > x)
                           then x : filtrarMenoresA n (xs)
                           else filtrarMenoresA n (xs)

  ejercicio 2.1.13 mal
mapLongitudes :: [[a]] -> [Int]
mapLongitudes [] = []
mapLongitudes (x:xs) = length x: mapLongitud xs

  ejercicio 2.1.15
intercalar :: a -> [a] -> [a] 
intercalar e [] = []
intercalar e (x:xs) = x: e : intercalar e xs-}

--ejercicio 2.1.18
aplanar :: [[a]] -> [a]
aplanar [] = []
aplanar (x:xs) = x ++ aplanar xs

--reverse x ++ recursiva[xs]
--ejercicio 2.1.19
--reversa :: [a] -> [a]
--reversa [] = []
--reversa 
                           





                       

 



