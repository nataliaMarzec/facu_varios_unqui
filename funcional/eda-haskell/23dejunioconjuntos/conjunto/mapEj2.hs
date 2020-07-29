
data Map k v = Mkmap [(k,v)] deriving (Show)

-- C:\Users\Nati\Desktop\23dejunioconjuntos\conjunto 
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


--domM :: Map k v -> Set k
--domM Emap = Eset 
--domM (Mkmap (k,v)) = 

--esto es como usuariooo!!!
--Implementar como usuario del tipo abstracto Map las siguientes funciones:
--1. indexar :: [a] -> Map Int a
--Dada una lista de elementos construye un Map que relaciona cada elemento con su posici´on
--en la lista.
indexar :: Int -> [a] -> Mkmap Int a 
indexar ind [x] = Mkmap [(ind,x)]
indexar ind (x:xs) = assocM (indexar (ind+1) xs) ind x

--["pepe","rojo","nada"]
--indexar Pablo
indexar2 :: [a] -> Map Int a 
indexar2 xs = indexar' xs 0 emptyM

indexar' :: [a] -> Int -> Map Int a -> Map Int a 
indexar' [] n mapa = mapa
indexar' (x:xs) n mapa = indexar' xs (n+1) (assocM mapa n x)


--2. pedirTelefonos :: [String] -> Map String Int -> [Maybe Int]
--Dada una lista de nombres de personas y un Map que relaciona nombres con n´umeros de
--tel´efonos, devuelve una lista con los n´umeros de las personas de la lista o Nothing en caso
--de que no posea n´umero.
--ghci:
--let listaDeNombres = ["Juan","Nahuel","Naty"]
--let agenda = Mkmap [("Juan",123)("Nahuel",456)]
--pablo
pedirTelefonos :: [String] -> Map String Int -> [Maybe Int]
pedirTelefonos [] agenda = []
pedirTelefonos (x:xs) agenda = (lookupM agenda x) : (pedirTelefonos xs agenda)


--3. ocurrencias :: String -> Map Char Int
--Dado un string cuenta las ocurrencias de cada caracter utilizando un Map.
--Indicar los ordenes de complejidad en peor caso de cada funci´on implementada.

--como usuario
ocu :: String -> Map Char Int
ocu texto = ocu' texto emptyM

--caso recursivo
ocu' :: String -> Map Char Int -> Map Char Int
ocu' [] mapa = mapa
ocu' (x:xs) mapa = ocu' xs (procesarLetra x mapa)

procesarLetra :: Char -> Map Char Int -> Map Char Int 
procesarLetra letra mapa = assocM mapa letra (sumar1 (lookupM mapa letra))

sumar1 :: Maybe Int -> Int
sumar1 Nothing = 1 
sumar1 (Just n) = n + 1 


 

