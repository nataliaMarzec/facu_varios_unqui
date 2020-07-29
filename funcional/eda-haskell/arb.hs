data Tree a = ET | MKT a (Tree a) (Tree a)

-- dado un arbol binario de enteros devuelve la suma
-- entre sus elementos

sumarT :: Tree Int -> Int
sumarT ET = 0
sumarT (MKT n left right) = n + (sumarT left) + (sumarT right)

--dado un arbol binario devuelve su cantidad de ellementos 
-- es decir, el tamaño del arbol (size en ingles)

sizeT :: Tree a -> Int
sizeT ET = 0
sizeT (MKT n left right) = 1 + (sizeT left) + (sizeT right)

--10 dada un arbol binario devuelve su cantidad de hojas
leaves :: Tree a -> Int

