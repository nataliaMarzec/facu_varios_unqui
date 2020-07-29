

sumRec [] = 0 --En caso de recibir una lista vacia retornar 0(casoBase)
sumRec (x:xs)=x+ sumRec xs