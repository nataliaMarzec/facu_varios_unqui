
-- Definimos el tipo de datos Tree para modelar árboles binarios.
-- Le pasamos una variable de tipo (a) ya que el árbol puede ser un árbol de muchas cosas.
--
-- Un árbol puede estar vacío o ser un nodo que tiene un valor y dos hijos.
-- El caso de árbol vacío lo llamamos ET (EmptyTree).
-- El caso de árbol con valor y dos hijos lo llamamos MkT (MakeTree) tiene tres parámetros,
-- el valor del nodo y los dos árboles que son sus hijos "izquierdo" y "derecho".
-- 
data Tree a = ET | MkT a (Tree a) (Tree a) deriving Show

-- Ej 1: Dado un arbol binario de enteros devuelve la suma entre sus elementos.
sumarT :: Tree Int -> Int
sumarT ET = 0
sumarT (MkT x left right) = x + (sumarT left) + (sumarT right)

-- Ej 2: Dado un arbol binario devuelve su cantidad de elementos, es decir, el tamaño del arbol (size en ingles).
sizeT :: Tree Int -> Int
sizeT ET = 0
sizeT (MkT x left right) = 1 + (sizeT left) + (sizeT right)

-- Ej 3: Dado un arbol de enteros devuelve un arbol con el doble de cada numero.
mapDobleT :: Tree Int -> Tree Int
mapDobleT ET = ET
mapDobleT (MkT x left right) = MkT (x*2) (mapDobleT left) (mapDobleT right)

-- Ej 6: Dados un elemento y un arbol binario devuelve True si existe un elemento igual a ese en el arbol.
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT buscado ET = False
perteneceT buscado (Mkt x left right) = if buscado == x 
                                            then True else 
                                            else (perteneceT buscado left) || (perteneceT buscado right)
