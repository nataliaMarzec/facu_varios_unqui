-- 3) Ejercicios POKEMON

-- 1) Definir los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta) y un porcentaje de
-- energía; y Entrenador, como un nombre y una lista de Pokemon. Luego definir las siguientes funciones:

data TipoDePokemon = Agua | Fuego | Planta deriving (Show, Eq)
type Energia = Float
data Pokemon = ConstPokemon TipoDePokemon Energia deriving (Show)

type NombreEntrenador = String
type ListaDePokemons = [Pokemon]
data Entrenador = ConstEntrenador NombreEntrenador ListaDePokemons

tipoPokemon :: Pokemon -> TipoDePokemon
tipoPokemon (ConstPokemon tipo _) = tipo

listaPokemons :: Entrenador -> ListaDePokemons
listaPokemons (ConstEntrenador _ ListaDePokemons) = ListaDePokemons

tieneEnergia :: Pokemon -> Bool
tieneEnergia (ConstPokemon _ e) = e > 0

elementoGanador :: TipoDePokemon -> TipoDePokemon
-- Dado un TipoDePokemon devuelve el elemento que le gana a ese.
-- Agua le gana a fuego, fuego a planta y planta a agua.
elementoGanador Fuego = Agua
elementoGanador Planta = Fuego
elementoGanador Agua = Planta

leGanaA :: Pokemon -> Pokemon -> Bool
-- Dados dos pokemon indica si el primero le puede ganar al segundo.
-- Se considera que gana si su elemento es opuesto al del otro pokemon.
-- Si poseen el mismo elemento se considera que no gana.
leGanaA pokemon1 pokemon2 = tipo1 == (elementoGanador tipo2)
                            where 
                                tipo1 = tipoPokemon pokemon1
                                tipo2 = tipoPokemon pokemon2

capturarPokemon :: Pokemon -> Entrenador -> Entrenador
-- Agrega un pokemon a la lista de pokemon del entrenador.
capturarPokemon pokemon (ConstEntrenador nombre xs) = ConstEntrenador nombre (pokemon : xs) 

cantidadDePokemons :: Entrenador -> Int
-- Devuelve la cantidad de pokemons que posee el entrenador.
cantidadDePokemons (ConstEntrenador nombre xs) = length xs

cantidadDePokemonsDeTipo :: TipoDePokemon -> Entrenador -> Int
-- Devuelve la cantidad de pokemons de determinado tipo que posee el entrenador.
cantidadDePokemonsDeTipo tipo entrenador = cantidadDePokemonsDeTipo' tipo (listaPokemons entrenador)

cantidadDePokemonsDeTipo' :: TipoDePokemon -> [Pokemon] -> Int
cantidadDePokemonsDeTipo' tipo [] = 0
cantidadDePokemonsDeTipo' tipo (x:xs) = if coincide
                                           then 1 + resto
                                           else resto
                                        where 
                                            coincide = tipo == (tipo x)
                                            resto = cantidadDePokemonsDeTipo' tipo xs

lePuedeGanar :: Entrenador -> Pokemon -> Bool
-- Dados un entrenador y un pokemon devuelve True si el entrenador posee un pokemon que le gane ese 
-- pokemon.
lePuedeGanar entrenador pokemon = lePuedeGanar' (listaPokemons entrenador) pokemon

lePuedeGanar' :: Entrenador -> Bool
lePuedeGanar' [] = False
lePuedeGanar' (x:xs) pokemon = if (leGanaA x pokemon)
                                    then True
                                    else lePuedeGanar' xs pokemon

{-puedePelear :: Tipo -> Entrenador -> Bool
puedePelear tipo entrenador = tieneUnPokemonConEnergia (pokemonsDeTipo tipo entrenador)

puedenPelear :: TipoDePokemon -> Entrenador -> Entrenador -> Bool
-- Dados un tipo de pokemon y dos entrenadores, devuelve True si ambos entrenadores tiene al menos un
-- pokemon de ese tipo y que tenga energía para pelear.
puedenPelear tipo entrenador1 entrenador2 = (puedePelear tipo entrenador1) && (puedePelear tipo entrenador2)
-}

esExperto :: Entrenador -> Bool
-- Dado un entrenador devuelve True si ese entrenador posee al menos un pokemon de cada tipo posible.
esExperto entrenador = (cantAgua > 0) && (cantFuego > 0) && (cantPlanta > 0)
                       where cantAgua = cantidadDePokemonsDeTipo Agua entrenador
                       where cantFuego = cantidadDePokemonsDeTipo Fuego entrenador
                       where cantPlanta = cantidadDePokemonsDeTipo Planta entrenador

fiestaPokemon :: [Entrenador] -> [Pokemon]
-- Dada una lista de entrenadores devuelve una lista con todos los pokemons de cada entrenador.
fiestaPokemon [] = []
fiestaPokemon (x:xs) = (listaPokemons x) ++ (fiestaPokemon xs)