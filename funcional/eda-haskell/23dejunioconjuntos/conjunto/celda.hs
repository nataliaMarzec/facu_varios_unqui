data Map k v = Mkmap [(k,v)] deriving (Show)
emptyM :: Map k v
emptyM = Mkmap []

-- agrega a lo sonso
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (Mkmap xs) clave valor = Mkmap ((clave,valor):xs)

--en orden
ordenados1 :: Ord k => [(k,v)] -> k -> v -> [(k,v)]
ordenados1 [] clave valor = [(clave,valor)]
ordenados1 ((k,v):xs) clave valor = if (clave > k)
                                     then ((k,v):(ordenados1 xs clave valor))
                                     else ((clave,valor):(k,v):xs)




--sin repetidos bien: busca la clave que coincide y si coincide le cambia el valor sino lo agrega              
assocMsinR' :: Eq k =>[(k,v)]-> k -> v -> [(k,v)]
assocMsinR' [] k v = [(k,v)]
assocMsinR' ((k,v):xs) clave valor = if clave == k 
                                           then ((k,valor):xs)
                                           else ((k,v): assocMsinR' xs clave valor)


                                           
--ghci                                                                              
--Main> let agenda = assocMsinR' (assocMsinR' (assocMsinR' (assocMsinR' [] "Pedro" 123) "Vale" 5896) "Rosa" 8795) "Peter" 456
--Main> agenda
--[("Pedro",123),("Vale",5896),("Rosa",8795),("Peter",456)]
--Main> let agenda = assocMsinR' (assocMsinR' (assocMsinR' (assocMsinR' [] "Pedro" 123) "Vale" 5896) "Rosa" 8795) "Pedro" 456
--Main> agenda
--[("Pedro",456),("Vale",5896),("Rosa",8795)]

                          
lookupM :: Eq k => Map k v -> k -> Maybe v
lookupM (Mkmap []) k = Nothing
lookupM (Mkmap ((k,v):xs)) clave = if clave == k 
                                  then Just v
                                  else lookupM (Mkmap xs) clave

deleteM :: Eq k => Map k v -> k -> Map k v
deleteM (Mkmap xs) clave = Mkmap (delete' xs clave)

delete' :: Eq k => [(k,v)] -> k ->[(k,v)]
delete' [] k = []
delete' ((k,v):xs) clave = if clave == k 
                                 then delete' xs clave 
                                 else (k,v):(delete' xs clave)


-----------------------------------------------------------------------------------------------------------------------------

--Ejercicio 3

data Color = Azul | Negro | Rojo | Verde deriving (Eq, Show)
data Celda = MkCelda (Map Color Int) deriving (Show)


--tipo de dato abstracto (lado de implementador):no puedo usar el mkmap
--El tipo abstracto Celda posee la siguiente interfaz:

celdaVacia :: Celda
celdaVacia = MkCelda (assocM (assocM (assocM (assocM emptyM Azul 0) Rojo 0) Negro 0) Verde 0)

--Crea una celda con cero bolitas de cada color
--Main> celdaVacia
--MkCelda (Mkmap [(Verde,0),(Negro,0),(Rojo,0),(Azul,0)])
--Main> let celda = MkCelda (Mkmap[(Verde,5),(Rojo,6)])
--Main> celda
--MkCelda (Mkmap [(Verde,5),(Rojo,6)])
------------------------------------------------------------------------------------------------------------------------
poner :: Color -> Celda -> Celda
poner c (MkCelda m) =  MkCelda (assocM m c (sumarUno (lookupM m c) ) )


sumarUno :: Maybe Int -> Int
sumarUno Nothing = 1
sumarUno (Just n) = n+1

--Agrega una bolita de ese color a la celda
--Main> poner Azul celdaVacia
--MkCelda (Mkmap [(Azul,1),(Verde,0),(Negro,0),(Rojo,0),(Azul,0)])

-----------------------------------------------------------------------------------------------------------------------
sacar :: Color -> Celda -> Celda
sacar c (MkCelda m) = (MkCelda (assocM m c (sinMaybe (lookupM m c)))) 

sinMaybe :: Maybe Int -> Int 
sinMaybe (Just n) = if n>0 then n-1 else 0 

--Saca una bolita de ese color, parcial cuando no hay bolitas de ese color
--Main> sacar Verde celdita
--MkCelda (Mkmap [(Verde,4),(Verde,5),(Rojo,6)])

-----------------------------------------------------------------------------------------------------------------------
nroBolitas :: Color -> Celda -> Int
nroBolitas c (MkCelda m) = sinMaybe4 (lookupM m c)

--Devuelve la cantidad de bolitas de ese color-
sinMaybe4 :: Maybe Int -> Int 
sinMaybe4 Nothing = 0
sinMaybe4 (Just n) = n 

--Main> let celda = MkCelda (Mkmap[(Verde,5),(Rojo,6)])
--Main> celda
--MkCelda (Mkmap [(Verde,5),(Rojo,6)])
--Main> nroBolitas Azul celda
--0

-----------------------------------------------------------------------------------------------------------------------

hayBolitas :: Color -> Celda -> Bool
hayBolitas c (MkCelda m) = (sinMaybe3 (lookupM m c)) > 0

sinMaybe3 :: Maybe Int -> Int 
sinMaybe3 Nothing = 0
sinMaybe3 (Just n) = 1 

--Indica si hay bolitas de ese color
--Main> celda
--MkCelda (Mkmap [(Verde,5),(Rojo,6)])
--Main> hayBolitas Verde celda
--True
--Main> hayBolitas Negro celda
--False

------------------------------------------------------------------------------------------------------------------------

--Defina este tipo abstracto utilizando la siguiente representacion:
--data Color = Azul | Negro | Rojo | Verde
--data Celda = MkCelda (Map Color Int)
--Inv. Rep.:
-- Existe una clave para cada color existente
-- El valor asociado a un color es un n´umero positivo
--como usuario no puedo poner el mkmap
--usuario de este tipo abstracto implemente las siguientes operaciones:

------------------------------------------------------------------------------------------------------------

nroBolitasMayorA :: Color -> Int -> Celda -> Bool
nroBolitasMayorA c n celda = (nroBolitas c celda ) > n 

--Devuelve True si hay mas de ”n”bolitas de ese color
--Main> let celda = MkCelda (Mkmap[(Verde,5),(Rojo,6)])
--Main> celda
--MkCelda (Mkmap [(Verde,5),(Rojo,6)])
--Main> hayBolitasDeCadaColor celda
--False
--Main> nroBolitasMayorA Rojo 7 celda
--False
--Main> nroBolitasMayorA Azul 3 celda
--False
--Main> nroBolitasMayorA Verde 3 celda
--True
----------------------------------------------------------------------------------------------------------

{-ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 c celda = celda 
ponerN  n c  celda = ponerN c (poner c celda) n-1 
--Agrega ”n”bolitas de ese color a la celda-}
-----------------------------------------------------------------------------------------------------------

hayBolitasDeCadaColor :: Celda -> Bool
hayBolitasDeCadaColor celda = (hayBolitas Rojo celda) && (hayBolitas Azul celda) && (hayBolitas Verde celda)
                               && (hayBolitas Negro celda)

--Indica si existe al menos una bolita de cada color posible
--Main> let celdaComp = MkCelda (Mkmap[(Verde,5),(Rojo,6),(Negro,3),(Azul,5)])
--Main> celdaComp
--MkCelda (Mkmap [(Verde,5),(Rojo,6),(Negro,3),(Azul,5)])
--Main> hayBolitasDeCadaColor celdaComp
--True
--Main> let celda = MkCelda (Mkmap[(Verde,5),(Rojo,6)])
--Main> celda
--MkCelda (Mkmap [(Verde,5),(Rojo,6)])
--Main> hayBolitasDeCadaColor celda
--False

--Indicar los ordenes de complejidad en peor caso de cada funci´on
-- de la interfaz y del usuario.


