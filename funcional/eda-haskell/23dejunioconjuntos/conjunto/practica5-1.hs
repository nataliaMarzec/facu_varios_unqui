


-- b) Dada una lista, devuelve su ultimo elemento.

last_v1 :: [a] -> a
last_v1 [x] = x
last_v1 (x:xs) = last_v1 xs

last_v2 :: [a] -> Maybe a
last_v2 [] = Nothing
last_v2 [x] = Just x
last_v2 (x:xs) = last_v2 xs



-- c) Dado un elemento y una lista devuelve la posicion de la lista en la que se encuentra
-- dicho elemento.

indiceDe_v1 :: Eq a => a -> [a] -> Int
indiceDe_v1 x (y:ys) = if x == y then 0 else 1 + (indiceDe_v1 x ys)

indiceDe_v2 :: Eq a => a -> [a] -> Maybe Int
indiceDe_v2 x [] = Nothing
indiceDe_v2 x (y:ys) = if x == y 
                        then Just 0 
                        else
                            case rst of Nothing -> Nothing
                                        Just v -> Just (v + 1)
                                        where rst = indiceDe_v2 x ys



-- d) Dada una lista de pares (clave, valor) y una clave devuelve el valor asociado a la clave.

valorParaClave_v1 :: Eq k => [(k,v)] -> k -> v
valorParaClave_v1 ((clave, valor):xs) claveBuscada = if claveBuscada == clave 
                                                        then valor
                                                        else valorParaClave_v1 xs claveBuscada

valorParaClave_v2 :: Eq k => [(k,v)] -> k -> Maybe v
valorParaClave_v2 [] claveBuscada = Nothing
valorParaClave_v2 ((clave, valor):xs) claveBuscada = if claveBuscada == clave 
                                                        then Just valor
                                                        else valorParaClave_v2 xs claveBuscada



-- e) Dada una lista de elementos devuelve el maximo.

maximum_v1 :: Ord a => [a] -> a
maximum_v1 [x] = x
maximum_v1 (x:xs) = if x > y then x else y where y = maximum_v1 xs

maximum_v2 :: Ord a => [a] -> Maybe a
maximum_v2 [] = Nothing
maximum_v2 [x] = Just x
maximum_v2 (x:xs) = Just (maximum_v1 (x:xs))


