data Tree a = ET | MkT a (Tree a) (Tree a) deriving Show

--Dado un arbol binario de enteros devuelve la suma entre sus elementos

sumarT :: Tree Int -> Int
sumarT  ET = 0
sumarT (MkT n left right) = n + (sumarT left) + (sumarT right)


--Dado un ´arbol binario devuelve su cantidad de elementos, es decir, el tama˜no del ´arbol (size
--en ingl´es)

sizeT :: Tree a -> Int
sizeT ET = 0
sizeT (MkT n left rigth) = 1 + (sizeT left) + (sizeT rigth) --hago algo con ese n, y hago dos llamadas recursivas

--3 mapDobleT :: Tree Int -> Tree Int
--Dado un ´arbol de enteros devuelve un ´arbol con el doble de cada n´umero.
mapDobleT :: Tree Int -> Tree Int
mapDobleT ET = ET
mapDobleT (MkT n left right) = MkT(2*n) (mapDobleT left) (mapDobleT right)

--4. mapOpuestoT :: Tree Dir -> Tree Dir
--Dado un ´arbol de direcciones t devuelve un ´arbol con la direcci´on opuesta para cada elemento
--de t.
--Nota: Utilizar el tipo Dir ya definido.


data Dir = Este | Oeste | Norte | Sur deriving Show --para q nos muestre el resultado por pantalla 

opuesto :: Dir -> Dir 
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Este = Oeste
opuesto Oeste = Este



mapOpuestoT:: Tree Dir -> Tree Dir
mapOpuestoT ET= ET
mapOpuestoT  (MkT d left right) =  MkT (opuesto d) (mapOpuestoT left) (mapOpuestoT right)

--5. mapLongitudT :: Tree String -> Tree Int
--Dado un ´arbol de palabras devuelve un ´arbol con la longitud de cada palabra.
mapLongitudT :: Tree String -> Tree Int
mapLongitudT ET = ET
mapLongitudT (MkT a left right) = MkT (length a) (mapLongitudT left) (mapLongitudT right)


--6. perteneceT :: Eq a => a -> Tree a -> Bool
--Dados un elemento y un ´arbol binario devuelve True si existe un elemento igual a ese en el
--arbol.
perteneceT :: Eq a => a -> Tree a -> Bool -- EQ lo que recibo se puede comparar
perteneceT a ET = False
perteneceT a (MkT e left right)=
              if (a == e) then True
                else
                  (perteneceT a left) || (perteneceT a right)

--7. aparicionesT :: Eq a => a -> Tree a -> Int
--Dados un elemento e y un ´arbol binario devuelve la cantidad de elementos del ´arbol que son
--iguales a e.


aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT e ET = 0
aparicionesT e (MkT a left right) = if e == a
                                      then 1 + (aparicionesT a left) + (aparicionesT a right)
                                        else
                                          (aparicionesT a left) + (aparicionesT a right)


--8. promedioEdadesT :: Tree Persona -> Int
--Dado un ´arbol de personas devuelve el promedio entre las edades de todas las personas.
--Definir las subtareas que sean necesarias para resolver esta funci´on.
--Nota: Utilizar el tipo Persona ya definido.
 


data Persona = ConsPersona String Int deriving Show

edad :: Persona -> Int
edad (ConsPersona elNombre laEdad) = laEdad

sumarEdad:: Tree Persona -> Int
sumarEdad ET = 0
sumarEdad (MkT p left right) = (edad p) + (sumarEdad left) + (sumarEdad right)

promedioEdadesT :: Tree Persona -> Int
promedioEdadesT ET = 0
promedioEdadesT (MkT p left right) = div (sumarEdad (MkT p left right))  (sizeT (MkT p left right))

--10. leaves :: Tree a -> Int
--Dado un ´arbol devuelve su cantidad de hojas.
--Nota: una hoja (leaf en ingl´es) es un nodo que no tiene hijos

--leaves :: Tree a -> Int
--leaves ET = 0
--leaves (MkT a _ _ ) = uno
--leaves (MkT a left right) = (leaves left) + (leaves right)

--11. heightT :: Tree a -> Int
--Dado un arbol devuelve su altura.
--Nota: la altura (height en ingles) de un arbol es la cantidad maxima de nodos entre la raz
--y alguna de sus hojas. La altura de un arbol vaco es cero y la de una hoja es 1.

heightT :: Tree a -> Int
heightT ET = 0
heightT (MkT a left right) = 1 + max (heightT left) (heightT right)

--12. nodes :: Tree a -> Int
--Dado un ´arbol devuelve el n´umero de nodos que no son hojas. ¿C´omo podr´ıa resolverla sin
--utilizar recursi´on? Primero def´ınala con recursi´on y despu´es sin ella.

nodes:: Tree a -> Int
nodes ET = 0
nodes (MkT a ET ET) = 0
nodes (MkT a left right) = 1 + (nodes left) + (nodes right)

--sin recursion 
--nodesBis:: Tree a -> Int
--nodesBis a = (size a) - (leaves a)

--13. espejoT :: Tree a -> Tree a
--Dado un arbol devuelve el arbol resultante de intercambiar el hijo izquierdo con el derecho,
--en cada nodo del arbol.
espejoT :: Tree a -> Tree a
espejoT ET = ET
espejoT (MkT a left right) = MkT a (espejoT right) (espejoT left)

--14. listInOrder :: Tree a -> [a]
--Dado un arbol devuelve una lista que representa el resultado de recorrerlo en modo in-order.
--Nota: En el modo in-order primero se procesan los elementos del hijo izquierdo, luego la raiz
--y luego los elementos del hijo derecho.
listInOrder :: Tree a -> [a]
listInOrder ET = []
listInOrder (MkT a left right) = (listInOrder left) ++ [a] ++ (listInOrder right)

--15. listPreOrder :: Tree a -> [a]
--Dado un arbol devuelve una lista que representa el resultado de recorrerlo en modo pre-order.
--Nota: En el modo pre-order primero se procesa la raiz, luego los elementos del hijo izquierdo,
--a continuacion los elementos del hijo derecho.
listPreOrder :: Tree a -> [a]
listPreOrder ET = []
listPreOrder (MkT a left right) = [a] ++  (listPreOrder left) ++ (listPreOrder right)


--16. listPosOrder :: Tree a -> [a]
--Dado un arbol devuelve una lista que representa el resultado de recorrerlo en modo post-
--order.
--Nota: En el modo post-order primero se procesan los elementos del hijo izquierdo, a conti-
--nuacion los elementos del hijo derecho y nalmente la raiz.
listPosOrder :: Tree a -> [a]
listPosOrder ET = []
listPosOrder (MkT a left right) = (listPosOrder left) ++ (listPosOrder right) ++ [a]

--17. concatenarListasT :: Tree [a] -> [a]
--Dado un arbol de listas devuelve la concatenacion de todas esas listas. El recorrido debe ser
--in-order.
concatenarListasT :: Tree [a] -> [a]
concatenarListasT (MkT a ET ET) = []
concatenarListasT (MkT a left right) = (concatenarListasT left) ++ a ++ (concatenarListasT right)


--18. levelN :: Int -> Tree a -> [a]
--Dados un numero n y un arbol devuelve una lista con los nodos de nivel n.
--Nota: El primer nivel de un arbol (su raiz) es 0.
levelN :: Int -> Tree a -> [a]
levelN _ ET = []
levelN 0 (MkT a left rigth) = [a]
levelN x (MkT a left rigth) = (levelN (x-1) left) ++ (levelN (x-1) rigth) 


--19. listPerLevel :: Tree a -> [[a]]
--Dado un arbol devuelve una lista de listas en la que cada elemento representa un nivel de
--dicho arbol.




--20. widthT :: Tree a -> Int
--Dado un arbol devuelve su ancho (width en ingles), que es la cantidad de nodos del nivel
--con mayor cantidad de nodos.