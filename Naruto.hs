import Text.Show.Functions
data Ninja = UnNinja {
    nombre :: String,
    rango :: Int, -- >=0
    herramientas :: [Herramienta],
    jutsus :: [Jutsu]
} deriving Show

type Herramienta = (String,Int)

-- Map Ninja

mapRango :: (Int -> Int) -> Ninja -> Ninja
mapRango unaFuncion unNinja = unNinja { rango = max 0.unaFuncion.rango $ unNinja }

mapHerramientas :: ([Herramienta] -> [Herramienta]) -> Ninja -> Ninja
mapHerramientas unaFuncion unNinja = unNinja { herramientas = unaFuncion.herramientas $ unNinja }

mapCantidad :: (Int -> Int) -> Herramienta -> Herramienta
mapCantidad unaFuncion (nombre,unaCantidad) = (nombre,unaFuncion unaCantidad)

-- P.1

obtenerHerramienta :: Herramienta -> Ninja -> Ninja
obtenerHerramienta unaHerramienta unNinja
    | (100 <=).(snd unaHerramienta +).cantidadDeHerramientas $ unNinja = mapHerramientas (unaHerramienta:) unNinja
    | otherwise = mapHerramientas (mapCantidad (min 99) unaHerramienta:) unNinja

cantidadDeHerramientas :: Ninja -> Int
cantidadDeHerramientas (UnNinja _ _ unasHerramientas _) = sum.map snd $ unasHerramientas

usarHerramienta :: Herramienta -> Ninja -> Ninja
usarHerramienta unaHerramienta = mapHerramientas (filter (/= unaHerramienta))

-- P.2

data Mision = UnaMision {
    ninjasRequeridos :: Int,
    rangoRecomendado :: Int,
    nijasEnemigos :: [Ninja],
    recompensa :: Herramienta
} deriving Show

-- Map Mision

mapNinjasRequeridos :: (Int -> Int) -> Mision -> Mision
mapNinjasRequeridos unaFuncion unaMision = unaMision { ninjasRequeridos = unaFuncion.ninjasRequeridos $ unaMision }

mapRangoMision :: (Int -> Int) -> Mision -> Mision
mapRangoMision unaFuncion unaMision = unaMision { rangoRecomendado = max 0.unaFuncion.rangoRecomendado $ unaMision }

mapNinjasEnemigos :: ([Ninja] -> [Ninja]) -> Mision -> Mision
mapNinjasEnemigos unaFuncion unaMision = unaMision { nijasEnemigos = unaFuncion.nijasEnemigos $ unaMision }

--

esDesafiante :: Mision -> [Ninja] -> Bool
esDesafiante (UnaMision _ rangoDeLaMision ninjasADerrotar _) unosNinjas = any (not.cumpleConElRango rangoDeLaMision) unosNinjas && ((2 >).length $ ninjasADerrotar)

cumpleConElRango :: Int -> Ninja -> Bool
cumpleConElRango unRango (UnNinja _ rangoDelNinja _ _) = rangoDelNinja >= unRango

esCopada :: Mision -> Bool
esCopada (UnaMision _ _ _ unaRecompensa) = elem unaRecompensa recompensasCopadas

recompensasCopadas :: [Herramienta]
recompensasCopadas = [("Bomba de humo",3),("Shuriken",5),("Kunai",14)]

esFactible :: Mision -> [Ninja] -> Bool
esFactible unaMision unosNinjas = (not.esDesafiante unaMision $ unosNinjas) && ((500 >).sum.map cantidadDeHerramientas $ unosNinjas)

--
mapRangoDelEquipo :: (Int -> Int) -> [Ninja] -> [Ninja]
mapRangoDelEquipo unaFuncion = map (mapRango unaFuncion)
--

fallarMision :: Mision -> [Ninja] -> [Ninja]
fallarMision (UnaMision _ rangoDeLaMision _ _) = mapRangoDelEquipo (subtract 2).filter (cumpleConElRango rangoDeLaMision)

cumplirMision :: Mision -> [Ninja] -> [Ninja]
cumplirMision (UnaMision _ _ _ unaRecompensa) = map (obtenerHerramienta unaRecompensa).mapRangoDelEquipo (+1)

--

type Jutsu = Mision -> Mision

clonesDeSombra :: Int -> Jutsu
clonesDeSombra cantidadDeClones = mapNinjasRequeridos (subtract cantidadDeClones)

fuerzaDeUnCentenar :: Jutsu
fuerzaDeUnCentenar = mapNinjasEnemigos (filter (cumpleConElRango 500))

ejecutarMision :: [Ninja] -> Mision -> [Ninja]
ejecutarMision unosNinjas unaMision = seCumpleLaMision unosNinjas.aplicarJutsusDelEquipo unaMision $ unosNinjas

seCumpleLaMision :: [Ninja] -> Mision -> [Ninja]
seCumpleLaMision unosNinjas unaMision 
    | esCopada unaMision || esFactible unaMision unosNinjas = cumplirMision unaMision unosNinjas
    | otherwise = fallarMision unaMision unosNinjas
 
aplicarJutsusDelEquipo :: Mision -> [Ninja] ->  Mision
aplicarJutsusDelEquipo unaMision = foldr ($) unaMision.concatMap jutsus

-- P.3

granGuerraNinja :: Mision
granGuerraNinja = UnaMision 10000 100 zetsus abanicoDeMadara

abanicoDeMadara :: Herramienta
abanicoDeMadara = ("Abanico de Madara Uchiha",1)

zetsus ::[Ninja]
zetsus = map zetsuN [1..]

zetsuN :: Int -> Ninja
zetsuN unNumero = UnNinja {
    nombre = "Zetsu" ++ show unNumero,
    rango = 600,
    herramientas = [],
    jutsus = []
}

{-

Si ejecutamos esDesafiante, gracias al lazy evaluation, la funcion comenzara a ejecutarse independientemente de que no la lista no este definida,
y a partir de aqui existen dos posibles caminos, el primero, donde la funcion retorna false dado que algun miembro no cumple con el rango, y el segundo camino,
donde la funcion se queda tratando de evaluar el length para poder realizar la comparacion y retornar un valor booleano
Debajo escribi una reedefinicion de la funcion pensada para que pueda funcion con listas infinitas, al ser infinita, el lado derecho del operador logico
siempre devolvera true, entonces retornara true o false de acuerdo a si algun miembro del equiopo ninja no cumple con el rango requerido.

esCopada retornara siempre false dado que se ejecuta gracias al lazy evaluation pero no cumple con la condicion de que la herramienta pertenezca
a las recompensas copadas

fuerzaDeUnCentenar comenzara a retornar la lista zetsuN, dado que al filtrar miembro por miembro y todos cumplen con la condicion del rango,
empezaran a aparecer zetsus de forma infinita en la terminal.

-}

-- Redefinicion de esDesafiante

esDesafiante2 :: Mision -> [Ninja] -> Bool
esDesafiante2 (UnaMision _ rangoDeLaMision ninjasADerrotar _) unosNinjas = any (not.cumpleConElRango rangoDeLaMision) unosNinjas && ((3 ==).length.take 3 $ ninjasADerrotar)

-- 

naruto :: Ninja
naruto = UnNinja "Naruto" 700 [shuriken,kunai] []
sasuke :: Ninja
sasuke = UnNinja "Sasuke" 600 [kunai,shuriken] []
kakashi :: Ninja
kakashi = UnNinja "Kakashi" 500 [kunai,shuriken] []
tomasin :: Ninja
tomasin = UnNinja "Tomasin" 56 [] []

shuriken :: Herramienta
shuriken = ("Shuriken",4)
kunai :: Herramienta
kunai = ("Kunai",1)
