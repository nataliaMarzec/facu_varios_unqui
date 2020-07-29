-- ej 7
import Persona
data Tree a = ET | MkT a (Tree a) (Tree a) deriving (Show,Eq)

aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT x ET = 0
aparicionesT x (Mkt a left right) = if (x == a)
                                 then 1 + (aparicionesT x left) (aparicionesT x right)
                                 else (aparicionesT x left)(aparicionesT x right)

--ej 8

sumarEdad :: Tree Persona ->Int
sumarEdad ET = 0
sumarEdad (Mkt p left right) = (edad p) + (sumarEdad left) + (sumarEdad right)

promedioEdadesT:: Tree Persona -> Int
promedioEdadesT ET = 0
promedioEdadesT (MkT p left right) = div (sumarEdad (MkT p left right)) (sizeT (MkT p left right))



