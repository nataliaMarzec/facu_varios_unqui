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


