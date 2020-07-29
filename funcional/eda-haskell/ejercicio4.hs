
--multiplicar *10 y devolver a otra lista

A10 =if (null xs)
      then []
      else
          (head xs *10) : A10(tail xs)

--multiplicar *10 y devolver a otra lista usando el matching

Adiez [] = []
Adiez(x:xs) = x*10 : Adiez(xs) 

                

          