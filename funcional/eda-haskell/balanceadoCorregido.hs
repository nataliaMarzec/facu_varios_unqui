
-- Stack / Pila
--
-- Vamos a implementar una Stack en Haskell.
-- Una Stack es un tipo abstracto de datos de naturaleza LIFO (last in, first
-- out). Esto significa que los últimos elementos agregados a la estructura son 
-- los primeros en salir (como en una pila de platos).
--
-- Su interfaz es la siguiente:
--
-- emptyStack :: Stack a
--  Crea una pila vacía.
--
-- isEmptyStack :: Stack a -> Bool
--  Dada una pila indica si está vacía.
--
-- push :: a -> Stack a -> Stack a
--  Dados un elemento y una pila, agrega el elemento a la pila.
--
-- top :: Stack a -> a
--  Dada un pila devuelve el elemento del tope de la pila.
--
-- pop :: Stack a -> Stack a
--  Dada una pila devuelve la pila sin el primer elemento.
--

data Stack a = MkS [a] Int deriving (Show, Eq)

-- El tipo de datos se llama Stack y se parametriza con una variable de tipo,
-- la idea es que podamos tener pilas de "cosas".
-- Internamente vamos a tener una lista para ir guardando los elementos de la pila,
-- y también vamos a tener la cantidad de elementos.

emptyStack :: Stack a
emptyStack = MkS [] 0

isEmptyStack :: Stack a -> Bool
isEmptyStack (MkS xs n) = n == 0

push :: a -> Stack a -> Stack a
push x (MkS xs n) = MkS (x:xs) (n + 1)

top :: Stack a -> a
top (MkS (x:xs) n) = x

pop :: Stack a -> Stack a
pop (MkS (x:xs) n) = MkS xs (n-1)


-----------------------------------------------------------------------------------------


-- Armar un Stack a partir de una lista.
apilarLista :: [a] -> Stack a
apilarLista xs = apilarLista' xs emptyStack

apilarLista' :: [a] -> Stack a -> Stack a
apilarLista' [] s = s
apilarLista' (x:xs) s = apilarLista' xs (push x s)


-- Armar una lista a partir de un Stack.
desapilarLista :: Stack a -> [a]
desapilarLista s = if isEmptyStack s 
                    then [] 
                    else (top s) : (desapilarLista (pop s))


-- Invertir texto.
invertirTexto :: [Char] -> [Char]
invertirTexto xs = desapilarLista (apilarLista xs)


-- Expresiones balanceadas.
-- ... se pidio como ejercicio para el martes 25!
balanceado :: String -> Bool
balanceado xs = balanceado' xs emptyStack

balanceado' :: String -> Stack Char -> Bool
balanceado' [] s = isEmptyStack s 
balanceado' ('(':xs) s= balanceado' xs (push '(' s)
balanceado' (')':xs) s= if isEmptyStack s 
                        then False
                        else (balanceado' xs (pop s))

balanceado'(x:xs) s = balanceado' xs s 
