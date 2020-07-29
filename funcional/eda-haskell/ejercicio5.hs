--patter matching
--practica 1 parte1
--Ejercicio 1

sucesor :: Int->Int
sucesor x = x + 1

maximo :: Int -> Int-> Int
maximo x y = if x >= y
             then x 
             else y

--Ejercicio 2
andLogico :: Bool-> Bool -> Bool
andLogico True True = True
andLogico _ _ = False

 --Ejercicio 2- d
       
primera :: (Int, Int) -> Int
primera (x,y)= x

--Ejercicio 2e
segunda :: (Int,Int)-> Int
segunda (x,y)= y

 --Parte3 
 --ejercicio 3a
loMismo :: a -> a 
loMismo x = x

 --ejercicio 3b
siempreSiete :: a -> Int 
siempreSiete x = 7

--ejercicio 4a
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _ = False

--ejercicio 4b
head' :: [a] -> a 
head' [] = "error la lista esta vacia"
head' (x:xs) = x

 --ejercicio 4c
tail':: [a] -> [a]
tail' [] = []
tail' (x:xs) = xs


--Practica1 parte2 

--ejercicio 1 
sumatoria:: [Int] -> Int 
sumatoria[] = 0
sumatoria (x:xs)= x+ sumatoria xs

--ejercicio 2
longitud :: [a]-> Int
longitud (x:xs) = 1 + longitud xs

--ejercicio 4
mapSucesor :: [Int] -> [Int]
mapSucesor [] = []
mapSucesor (x:xs) = (x+1) : mapSucesor xs

--ejercicio5
mapSumaPar :: [(Int,Int)] -> [Int]
mapSumaPar [] = []
mapSumaPar ((a,b):xs)= (a+b) : mapSumaPar xs

--ejercicio2.1.7
todoVerdad :: [Bool]-> Bool
todoVerdad [] = False
todoVerdad [x] = x
todoVerdad (x:xs) = x && todoVerdad xs

--ejercicio 2.1.8 corregir
algunaVerdad :: [Bool] -> Bool
algunaVerdad [] = False
algunaVerdad (x:xs)= x || algunaVerdad xs

--ejercicio 2.1.9
pertenece :: Eq a -> a -> [a] ->Bool
pertenece [] = False
pertenece a(x:xs) = a==x ||pertenece a xs

--ejercicio 2.1.10












