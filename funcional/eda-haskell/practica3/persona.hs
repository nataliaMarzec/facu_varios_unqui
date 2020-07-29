module Persona where

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

--let arb = MkT (ConsPersona "Manu" 38) (MkT (ConsPersona "Enzo" 5) (MkT (ConsPersona "Maia" 8) ET ET) (MkT (ConsPersona "Eli" 38) ET ET)
--) (MkT (ConsPersona "Emi" 3) (MkT (ConsPersona "Fran" 1) ET ET) (MkT (ConsPersona "Pepe" 17) ET ET))