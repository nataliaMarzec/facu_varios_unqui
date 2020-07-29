data SensacionTermica = HaceFrio | HaceCalor deriving Show

data Figura = Circulo Float | Rect Float Float deriving Show

ancho :: Figura -> Float
ancho (Rect a l) = a

radio :: Figura -> Float
radio (Circulo r) = r

area :: Figura -> Float
area (Circulo r) = pi * r^2
area (Rect a l) = a * l

esCirculo :: Figura -> Bool
esCirculo (Circulo _) = True
esCirculo _ = False

-- Esto es para Vale, para forzar que el primer dato sea el ancho y el segundo el largo
data DataAncho = Ancho Float deriving Show
data DataLargo = Largo Float deriving Show
data Figura2 = Circulo2 Float | Rect2 DataAncho DataLargo deriving Show





