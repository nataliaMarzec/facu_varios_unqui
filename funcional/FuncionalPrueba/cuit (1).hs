import Char

data Genero = Femenino | Masculino deriving Show
--                             dni      cuit
data Persona = Persona Genero Integer Integer deriving Show

cuitsOk :: [Integer]
cuitsOk = [20929014740, 20391469807, 27247214300, 23273715789, 23393716134, 23393718064]

cuitsNOk :: [Integer]
cuitsNOk = [20929014741, 27929014740, 20929814740, 20391469800, 27247214305, 27247294300, 27273715789, 20393718064]

personas :: [Persona]
personas = [Persona Masculino 92901474 20929014740,
            Persona Femenino 24721430 27247214300,
            Persona Masculino 39146980 20391469807,
            Persona Masculino 27371578 23273715789,
            Persona Femenino 39371613 23393716134,
            Persona Femenino 39371806 23393718064]

secuencia :: [Integer]
secuencia = [2,3,4,5,6,7,2,3,4,5]

eslongitudOnce:: Integer -> Bool
eslongitudOnce n = (length (cifrar n)) == 11

esPrefijoCorrecto n = obtenerTipo n == (cifrar 23) || obtenerTipo n == (cifrar 20) || obtenerTipo n == (cifrar 27)

esDigitoVerificador n = obtenerDv n == calcularDv n

analiza :: Integer -> Bool
analiza n = eslongitudOnce n && esPrefijoCorrecto n && esDigitoVerificador n
                     
cuitEntero n=  obtenerTipo n ++ dni n ++ calcularDv n

genera :: Genero -> Integer -> Integer
genera Femenino d = if (calcularDv(convertirANumero(cifrar 27 ++ cifrar d)))== cifrar 10
                    then (convertirANumero(calcularDv(convertirANumero(cifrar 23 ++ cifrar d))))
                    else (convertirANumero(calcularDv(convertirANumero(cifrar 27 ++ cifrar d))))
genera Masculino d = if (calcularDv(convertirANumero(cifrar 20 ++ cifrar d)))== cifrar 10
                    then (convertirANumero(calcularDv(convertirANumero(cifrar 23 ++ cifrar d))))
                    else (convertirANumero(calcularDv(convertirANumero(cifrar 20 ++ cifrar d))))
                    
-- generaLista (g,d: xs) = genera g d : generaLista xs 


generoPersona:: Integer -> Genero
generoPersona n | (obtenerTipo n == cifrar 23 || obtenerTipo n == cifrar 27 ) = Femenino 
                |obtenerTipo n == cifrar 20 = Masculino

informa n = (generoPersona n , show (convertirANumero(obtenerTipo n)) ++ "/" ++ show(convertirANumero(dni n)) ++"/" ++ show (convertirANumero (calcularDv n)))

informalista (xs) = map informa  xs

cifrar :: Integer -> [Integer]
cifrar n = [read [x] | x <- show n]

convertirANumero:: [Integer] -> Integer
convertirANumero (xs) = read $ map (\i -> intToDigit (fromIntegral i :: Int)) xs

dni n = drop 2 (take 10 $cifrar n)

obtenerTipo :: Integer ->[Integer]
obtenerTipo x = take 2 $ cifrar x
         
obtenerDv :: Integer -> [Integer]
obtenerDv n = cifrar(n `mod` 10)

modeOnceDv :: Integer -> [Integer]
modeOnceDv n = cifrar (11 - ((sumaCuit n) `mod` 11))

calcularDv n = if modeOnceDv n == (cifrar 11)
               then cifrar 0 
               else modeOnceDv n 


sumaCuit n =sum (zipWith (*) (drop 1(cifrar(invertir n))) secuencia)

invertir n = read (reverse (show n))

testAnaliza :: String
testAnaliza = if todoOk
              then "Todo Ok"
              else mensajeError
    where todoOk = (and $ map analiza cuitsOk) 
                && (not $ or $ map analiza cuitsNOk)
          mensajeError = "Todo Mal! - CUIT buenos reconocidos malos: " ++ errCuitsOk ++ 
                                  " - CUIT malos reconocidos como buenos: " ++ errCuitsNOk
          errCuitsOk  = show $ filter (not.analiza) cuitsOk
          errCuitsNOk = show $ filter analiza cuitsNOk

testGenera :: String
testGenera = if todoOk
             then "Todo Ok"
             else mensajeError
    where todoOk = and $ map cuitOk personas
          cuitOk (Persona g dni cuit) = (genera g dni) == cuit
          mensajeError = "Todo Mal! - Personas con CUIT mal generado: " ++ errCuits
          errCuits = show $ filter (not.cuitOk) personas
