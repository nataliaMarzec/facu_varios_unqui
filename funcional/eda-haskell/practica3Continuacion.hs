-- ej 7
data Tree a = ET | MkT a (Tree a) (Tree a) deriving (Show,Eq)
-- let t= MkT 2 (MkT 3 (MkT 7 ET ET) (MkT 9 ET ET)) (MkT 5 (MkT 1 ET ET) (MkT 3 ET ET))

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
heightT (MkT X ET ET) = 1
heightT (MkT x left right) = 1 + max (heightT left)(heightT right)

--ej 12
nodes :: 




