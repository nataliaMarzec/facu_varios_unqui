data Nat = Cero | Suc Nat deriving Show

cero :: Nat
cero = Cero

uno = Suc Cero

dos = Suc uno

-- data [a] = [] | (a:[a]) -> esta sintaxis es inválida, es solo ilustrativa
data Lista a = Vacia | Cons a (Lista a) deriving Show

fromHaskellListToLista :: [a] -> Lista a
fromHaskellListToLista [] = Vacia
fromHaskellListToLista (x:xs) = Cons x (fromHaskellListToLista xs)

fromListaToHaskellList :: Lista a -> [a]
fromListaToHaskellList Vacia = []
fromListaToHaskellList (Cons x xs) = x:(fromListaToHaskellList xs)

data ArbolBin a = Hoja a | Nodo a (ArbolBin a) (ArbolBin a) deriving Show

arbol1 = Hoja 5
arbol2 = Nodo 5 (Hoja 6) (Hoja 7)
arbol3 = Nodo 5 (Hoja 6) (Nodo 7 (Hoja 2) (Hoja 1))

data ArbolBin2 a = Nulo2 | Hoja2 a | Nodo2 a (ArbolBin2 a) (ArbolBin2 a) deriving Show
arbol4 = Nodo2 2 (Nodo2 4 (Hoja2 1) (Hoja2 2)) Nulo2
hoja1 = Hoja2 5
hoja2 = Nodo2 5 Nulo2 Nulo2

-- Esta definición de árbol genérico funciona pero es ambigua
-- data ArbolGen a = HojaG a | NodoG a [ArbolGen a] deriving Show
-- arbol5 :: ArbolGen Int
-- arbol5 = NodoG 5 [HojaG 8, HojaG 9, (NodoG 10 [HojaG 20])]
-- hoja3 = HojaG 1
-- hoja4 = NodoG 1 []

-- Para resolver la ambiguedad simplemente se elimina el constructor HojaG
data ArbolGen a = NodoG a [ArbolGen a] --deriving Show
instance Show a => Show (ArbolGen a) where
    showsPrec _ t = showTree 0 t
showTree i (NodoG e []) s = (replicate i ' ') ++ "Hoja " ++ (show e) ++ "\n" ++ s
showTree i (NodoG e (x:xs)) s = (replicate i ' ') ++ "Nodo " ++ (show e) ++ "\n" ++ (foldr (showTree (i+3)) "" (x:xs)) ++ s
 

arbol5 :: ArbolGen Int
arbol5 = NodoG 5 [NodoG 8 [], NodoG 9 [], (NodoG 10 [NodoG 20 [], NodoG 21 [NodoG 31 [], NodoG 32 []]]), (NodoG 11 [NodoG 22 []])]
hoja4 = NodoG 1 []

-- Solución Fede
hojas :: ArbolGen a -> Int
hojas (NodoG e []) = 1
hojas (NodoG e (x:xs)) = sum (recorreArbol (NodoG e (x:xs)))

recorreArbol :: ArbolGen a -> [Int]
recorreArbol (NodoG e []) = []
recorreArbol (NodoG e (x:xs)) = (hojas x):(recorreArbol (NodoG e xs))

-- Solución Profe
hojas2 :: ArbolGen a -> Int
hojas2 (NodoG e []) = 1
hojas2 (NodoG e (x:[])) = hojas2 x
hojas2 (NodoG e (x:xs)) = (hojas2 x) + (hojas2 (NodoG e xs))

-- Solución Fede-Profe
hojas3 :: ArbolGen a -> Int
hojas3 (NodoG e []) = 1
hojas3 (NodoG e (x:xs)) = sum (map hojas3 (x:xs))

-- Suma
sumarArbol :: ArbolGen Int -> Int
sumarArbol (NodoG e []) = e
sumarArbol (NodoG e (x:xs)) = sumarArbol x + sumarArbol (NodoG e xs)

sumarArbol2 :: ArbolGen Int -> Int
sumarArbol2 (NodoG e []) = e
sumarArbol2 (NodoG e (x:xs)) = e + sum (map sumarArbol2 (x:xs))

sumarArbol3 :: ArbolGen Int -> Int
sumarArbol3 (NodoG e xs) = e + sum (map sumarArbol3 xs)


-- Duplicar
duplicarArbol :: ArbolGen Int -> ArbolGen Int
duplicarArbol (NodoG e xs) = (NodoG (e*2) (map duplicarArbol xs))

-- Altura
altura :: ArbolGen a -> Int
altura (NodoG e []) = 0
altura (NodoG e (x:xs)) = 1 + maximum (map altura (x:xs))

-- Preorder
preorderGen :: ArbolGen a -> [a]
preorderGen (NodoG e []) = [e]
preorderGen (NodoG e (x:xs)) = e:(concat (map preorderGen (x:xs)))

-- Posorder
--posorderGen :: ArbolGen a -> [a]



