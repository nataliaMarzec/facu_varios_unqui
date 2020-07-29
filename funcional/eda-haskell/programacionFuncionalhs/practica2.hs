map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x:xs)= f x:map' f xs

filter' :: (a -> Bool) -> [a]-> [a]
filter' f [] = []
filter' f (x:xs) = if f x 
                then (x : filter' f xs) 
                else filter' f xs

--any recibe un predicao p y una lista de a 
--devuelve True si al menos un elemento cumple p (o x == Trye)   
anyS :: (a -> Bool) -> [a] -> Bool
anyS f xs = not (null (filter' f xs))

--o otra opcion
--anyS f xs = lenght (filter' f xs) > 0

--all recibe un predicado p y una lista de a
--devuelve True si todos los elementos x cumple (p)
alls :: (a -> Bool) -> [a] -> Bool
alls f xs = length xs == length (filter f xs)

--suma lista
suma :: [Int] -> Int
suma = foldr (+) 0

--suma es lo mismo por currificacion 
--suma xs = foldr (+) 0 xs

--evaluation lazy
-- primero se toma TODA la funcion y después se opera
-- *TODA: es ventajosa en casos de infinitos,pero en caso de 
--parametros con funciones muuuy largas conviene EAGER. Por de
--fecto Haskell funciona con Lazy

--si son recursivas se usa foldr

--foldr ::(a->b->b)->b-> [a] ->b 
--para que algo sea recursiva tiene que recibir una lista
--apply : recibeuna funcion f y la aplica al 2do parametro

--anyS :: (a -> Bool) -> [a] -> Bool
--anyS f xs = not (null (filter' f xs))
--anyS f xs = lenght (filter' f xs) > 0


--apply' :: (a->b) -> a -> b 
--apply' f x = f x 
--apply f = (x -> f x)
-- twice' aplica una funcion 2 veces
twice :: (a->a)-> a -> a 
twice f x = f(f x)

--flip recibe una funcion de dos argumentos y los invierte
flip :: (a->b->c)-> b -> a -> c 
flip f x y = f y x
--flip f= 

-- (.) composicion de funciones
--(.):: (b->c)-> (a->b)->(a->c)
composicion f g x = f (g(x))

--curry recibe una funcion no currificada (de dos argumentos)
--y devuelve otra currificada

curry' :: ((a,b)-> c) ->a -> b ->c 
curry' f x y = f (x,y)

uncurry' :: (a -> b -> c) -> (a,b) -> c
uncurry' f (x,y) = f x y 

--hacer mapFdr, filterFdr, anyfdr, allfdr
--TAREAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!!

--maploco : alto orden, currificacion usando composicion .

maybe' :: b->(a->b) -> Maybe a -> b 
maybe' x f Nothing = x 
maybe' x f (Just a)  = f a 

--se puede probar asi:
--maybe (-9999) (\x->x*2)(divisionSegura 5 8)
--maybe (-9999) (\x->x*2)(Just 9)
-- o con Nothing


