data Map k v = Mkmap [(k,v)] deriving (Show)

emptyM :: Map k v
emptyM = Mkmap []

-- busca la clave que coincide y si coincide le cambia el valor sino lo agrega
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (Mkmap xs) k v = Mkmap ((k,v):xs)

--en orden
ordenados1 :: Eq k => [(k,v)]-> k -> v -> [(k,v)]
ordenados1 [] k v = [(k,v)]
ordenados1 [(k,v)] clave valor = if (clave > k)
                                     then ((k,v):(ordenados1 xs clave valor))
                                     else ((clave,valor):(k,v):xs)

--sin repetidos mal:lo pasaria asi(como esta abajo) pero no puedo porque esta mal
--assocMsinR' (assocMsinR' (assocMsinR' (assocMsinR' emptyM "Pedro" 123) "Vale" 5896) "Rosa" 8795) "Pedro" 456
--assocMsinR' :: Eq k =>Map k v -> k -> v -> Map k v
--assocMsinR' (Mkmap []) k v = Mkmap [(k,v)]
--assocMsinR' (Mkmap ((k,v):xs)) clave valor = if clave == k 
                                         --  then Mkmap ((k,valor):xs)
--sin repetidos bien:                    --  else Mkmap (k,v) : assocMsinR' (Mkmap xs) clave valor
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
--domM (Mkmap (k,v)) = --verrr 

