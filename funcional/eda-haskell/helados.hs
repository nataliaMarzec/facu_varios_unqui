--tipo de datos definidos por los usuarios
--ejemplo de helados

--tenemos los siguientes gustos, definimos un
--tipo de datos Enumerativo para representarlos

data Gusto= Chocolate | DulceDeLeche | Sanbayon | Granizado | Americano

--vamos a tener tres tipos de helados
--el vasito que puede tener un gusto
--el balde que puede tener uno o mas gustos

data Helado= Vasito Gusto |Cucurucho Gusto Gusto |
             Balde [Gusto] 

-- queremos saber que tipo de helado Tenemos
--la funcion es vasito, recibe un helado y devuelve true o false
-- dependiendo de si es un vasito o no

esVasito :: Helado -> Bool
esVasito Vasito_ = True
esVasito_ = False

esCucurucho :: Helado -> Bool
esBalde :: Helado -> Bool

-- Vamos a hacer una funcion que devuelva el gusto de un vasito
gustoDelVasito :: Helado -> Gusto
gustoDelVasito (Vasito g) = g

--calcular los precios
 --el vasito vale 5$
 --el Cucurucho 10$
 --el balde 10 + ($3 por gusto)

calcularPrecio :: Helado -> Int
calcularPrecio (Vasito _) = 5
calcularPrecio (cucurucho _ _)= 10
calcularPrecio (Balde gustos)= 10 + (3* (length gustos))




