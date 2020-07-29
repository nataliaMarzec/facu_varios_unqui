data Tree a = ET | MkT a (Tree a) (Tree a) deriving (Show,Eq)

--ej 1
sumarT :: Tree Int -> Int
sumarT ET = 0
sumarT (MkT n left right)= n + (sumarT left)+(sumarT right)

--ej2
sizeT :: Tree a -> Int
sizeT ET = 0
sizeT (MkT x left right)= 1 + (sizeT left)+(sizeT right)

--ej 3
mapDobleT :: Tree Int -> Tree Int
mapDobleT ET = ET
mapDobleT (MkT n left right) = MkT (n*2) (mapDobleT left)(mapDobleT right)

--ej 5 Ver

data Dir = Norte | Sur | Este | Oeste deriving (Show)

opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Oeste = Este
opuesto Este = Oeste 

mapOpuestoT :: Tree Dir -> Tree Dir
mapOpuestoT ET = ET
mapOpuestoT (MkT x left right) = MkT (opuesto x) (mapOpuestoT left) (mapOpuestoT right)

-- EJ 6
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT x ET = False
perteneceT x (MkT e left right) = if (x==e)
then True 
else (perteneceT x left) || (perteneceT x right) 

--ej 5
mapLongitudT :: Tree String -> Tree Int
mapLongitudT ET = ET
mapLongitudT (MkT x left right)= MkT (length x) (mapLongitudT left) (mapLongitudT right)

--ej 7
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT x ET = 0
aparicionesT x (MkT a left right) = if (x == a)
                                 then 1 + (aparicionesT x left)+(aparicionesT x right)
                                 else (aparicionesT x left)+(aparicionesT x right)

--ej 8 VER
--promedioEdadesT:: Tree Persona -> Int
--promedioEdadesT ET = 0
--promedioEdadesT (MkT p left right)=  div sumarEdad(MkT p left right) sizeT(MkT P left right)

--sumarEdadT :: Tree Persona -> Int
--sumarEdadT ET = 0
--sumarEdadT (MkT p left right) = edadP + sumarEdadT left 

--EJ 9 SUMARYENGANCHAREDAD

--EJ 10 dado un arbol devuelve su cantidad de hojas(leaves)
leaves :: Tree a -> Int
leaves (MkT x ET ET) = 1
leaves (MkT x left right) = (leaves left)+(leaves right) 

--ej 11
heightT :: Tree a -> Int
heightT ET= 0
heightT (MkT x left right) = 1 + (max (heightT left)(heightT right))

--ej 12 
nodes :: Tree a -> Int
nodes ET= 0
nodes (MkT _ ET ET)= 0 --CUANTOS NODOS Q NO SON HOJAS?
nodes (MkT _ left right) = 1 + (nodes left)(nodes right)

--ej 
--espejoT :: Tree a -> Tree a

--cualquier nivel que me pidan si tengo un arbol vacio, tengo una lista vacia
levelN :: Int -> Tree a -> [a]
levelN _ ET = [] 
levelN 0 (Mkt a left rigth)= 



