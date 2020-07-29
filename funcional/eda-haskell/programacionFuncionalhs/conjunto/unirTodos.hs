data Conjunto a = MKSet [a] Int deriving (Show,Eq)
data Tree a = ET | MkT a (Tree a) (Tree a)

vacioC :: Conjunto a
vacioC = MKSet [] 0

unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unionC (MkSet [] c) set2 = set2
unionC (MkSet (x:xs) c1) set2 = unionC (MkSet xs (c1-1)) (agregarC x set2)

unirTodos :: Tree (Conjunto a) -> Conjunto a 
unirTodos ET = VacioC
unirTodos (MkT set left right) = unionC set (unirTodos left) (unirTodos right)