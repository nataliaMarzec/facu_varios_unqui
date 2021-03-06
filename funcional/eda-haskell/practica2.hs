
--PRACTICA 2

--ej 2

data Dir = Norte | Sur | Este | Oeste deriving (Show)

opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Oeste = Este
opuesto Este = Oeste 

siguiente :: Dir -> Dir
siguiente Norte = Este
siguiente Este = Sur
siguiente Sur = Oeste
siguiente Oeste = Norte

--ej 1.2
--registro

data Persona = ConstructorPersona String Int deriving (Show)

nombre :: Persona -> String
nombre (ConstructorPersona nombre edad)  = nombre

edad :: Persona -> Int 
edad (ConstructorPersona nombre edad ) = edad

crecer :: Persona -> Persona
crecer (ConstructorPersona nombre edad) = ConstructorPersona nombre (edad+1)

cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre  nombreNuevo (ConstructorPersona nombre edad) = ConstructorPersona nombreNuevo edad

cambioDeNombre2 :: String -> Persona -> Persona
cambioDeNombre2 n p = ConstructorPersona n (edad p)

esMenorQueLaOtra :: Persona -> Persona -> Bool
esMenorQueLaOtra p1 p2 = (edad p1) < (edad p2)

mayoresA :: Int -> [Persona] -> [Persona]
mayoresA edad [] = []
mayoresA edad (p:ps)= if (edad p) > edad
                      then p: (mayoresA edad ps)
                      else (mayoresA edad ps)










