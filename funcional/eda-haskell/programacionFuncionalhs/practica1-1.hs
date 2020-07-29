id' :: a -> a
id' x = x

const' :: a -> b -> a
const' x y = x

fst' :: (a,b) -> a
fst' (x,y) = x

snd' :: (a,b) -> b
snd' (x,y) = y

swap' :: (a,b) -> (b,a)
swap' (x,y) = (y,x)

hd :: [a] -> a
hd (x:xs) = x

tl :: [a] -> [a]
tl (x:xs) = xs

nll :: [a] -> Bool
nll [] = True
nll (x:xs) = False

sm :: Num a => [a] -> a
sm [] = 0
sm (x:xs) = x + sm xs

pdct :: Num a => [a] -> a
pdct [] = 1
pdct (x:xs) = x * pdct xs

pdct' :: Num a => [a] -> a
pdct' xs = if nll xs
            then 0
            else pdct xs

pdct'' :: Num a => [a] -> a
pdct'' [] = 0
pdct'' (x:[]) = x
pdct'' (x:y:xs) = x * pdct'' (y:xs)

leng :: [a] -> Int
leng [] = 0
leng (x:xs) = 1 + leng xs

elm :: Eq a => a -> [a] -> Bool
elm e [] = False
elm e (x:xs) = if e == x
                then True
                else elm e xs

elm' :: Eq a => a -> [a] -> Bool
elm' e [] = False
elm' e (x:xs) = e == x || elm' e xs

notElm :: Eq a => a -> [a] -> Bool
notElm e xs = not (elm e xs)

and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) = x && and' xs

or' :: [Bool] -> Bool
or' [] = False
or' (x:xs) = x || or' xs

count :: Eq a => a -> [a] -> Int
count e [] = 0
count e (x:xs) = if e == x
                    then 1 + count e xs
                    else count e xs

last' :: [a] -> a
last' [x] = x
last' (x:xs) = last' xs

init' :: [a] -> [a]
init' [x] = []
init' (x:xs) = x:(init' xs)

cons :: a -> [a] -> [a]
cons e xs = e:xs

snoc :: [a] -> a -> [a]
snoc [] e = [e]
snoc (x:xs) e = x:(snoc xs e)

