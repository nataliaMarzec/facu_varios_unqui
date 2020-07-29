data Bst a = Mkt a (Bst a) (Bst a) | ET deriving (Show,Eq,Ord)
 --Mkt 2 (Mkt 3 (Mkt 7 ET ET) (Mkt 9 ET ET)) (Mkt 5 (Mkt 1 ET ET) (Mkt 3 ET ET))

isEmpty :: Bst a -> Bool
isEmpty ET = True
isEmpty (Mkt _ left right) = False

insertarBst :: Ord a => n-> Bst a -> Bst a
insertarBst ET = ET
insertarBst n (Mkt a left right) = if n==a then (Mkt a left right)
                                  else 
                                  if n<a then (MKt insertarBst n left)
                                  else 
                                  if n>a then (Mkt insertarBst n right)
                                  else (insertarBst Mkt a left right)

{-perteneceBst :: Ord a => a -> Bst a -> Bool
perteneceBst _ ET = False
perteneceBst a (Mkt e left right)= if a==e then True
                                     else 
                                     if a<e then (perteneceBst a left)
                                     else 
                                     if a>e then (perteneceBst a right)
                                     else False 

minimoBst :: Ord a => Bst a -> Int
--a,left(y abajo hay un et) right = devuelve a 
minimoBst (Mkt _ left right) = (minimoBst left) 

sucesor :: Ord a => a -> Bst a -> Int 
sucesorBst n (Mkt _ left right) = minimoBst (sucesorBst right)-}

