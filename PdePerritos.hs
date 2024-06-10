data Perro = UnPerro {
    raza :: String,
    juguetesFavoritos :: [Juguete],
    tiempoEnLaGuarderia :: Int, -- En minutos
    energia :: Int 
} deriving Show 

type Juguete = String

-- Map Perro

mapJuguete :: ([Juguete] -> [Juguete]) -> Perro -> Perro
mapJuguete unaFuncion unPerro = unPerro {juguetesFavoritos = unaFuncion.juguetesFavoritos $ unPerro}

mapEnergia :: (Int -> Int) -> Perro -> Perro
mapEnergia unaFuncion unPerro = unPerro {energia = max 0.unaFuncion.energia $ unPerro}

-- P.1

type ModificarPerro = Perro -> Perro

jugar :: ModificarPerro
jugar = mapEnergia (subtract 10)

ladrar :: Int -> ModificarPerro
ladrar cantidadDeLadridos = mapEnergia (+ div cantidadDeLadridos 2)

regalar :: Juguete -> ModificarPerro
regalar unJuguete = mapJuguete (unJuguete:)

diaDeSpa :: ModificarPerro
diaDeSpa (UnPerro unaRaza unosJuguetes tiempoEnGuarderia unaEnergia)
    | 50 <= tiempoEnGuarderia || esDeRazaExtravagante unaRaza = mapJuguete ("Peine de goma":).mapEnergia (const 100) $ UnPerro unaRaza unosJuguetes tiempoEnGuarderia unaEnergia
    | otherwise = UnPerro unaRaza unosJuguetes tiempoEnGuarderia unaEnergia

--
esDeRazaExtravagante :: String -> Bool
esDeRazaExtravagante unaRaza = elem unaRaza razasExtravagante

razasExtravagante :: [String]
razasExtravagante = ["Dalmata","Pomerania"]
--

diaDeCampo :: ModificarPerro
diaDeCampo = mapJuguete (drop 1)

zara :: Perro
zara = UnPerro "Dalmata" ["Pelota","Mantita"] 90 80

data Rutina = UnaRutina {
    ejercicios :: [ModificarPerro],
    tiempoPorEjercicio :: [Int]
} 

guarderiaPdePerritos :: Rutina 
guarderiaPdePerritos = UnaRutina {
    ejercicios = [diaDeCampo,diaDeSpa,regalar "Pelota",ladrar 18,jugar], 
    tiempoPorEjercicio = [720,120,0,20,30]
}

-- P.2 

type EvaluarPerro = Perro -> Bool

puedePermanecerEnLaGuarderia :: Rutina -> EvaluarPerro
puedePermanecerEnLaGuarderia unaRutina (UnPerro _ _ tiempoEnLaGuarderia _) = (tiempoEnLaGuarderia >=).tiempoDeLaRutina $ unaRutina

--
tiempoDeLaRutina :: Rutina -> Int 
tiempoDeLaRutina = sum.tiempoPorEjercicio 
--

cualesSonPerrosResponsables :: [Perro] -> [Perro]
cualesSonPerrosResponsables = filter esPerroResponsable 

--
esPerroResponsable :: EvaluarPerro
esPerroResponsable = (> 3).length.juguetesFavoritos.diaDeCampo 
--

realizarRutina :: Rutina -> ModificarPerro 
realizarRutina unaRutina unPerro  
    | puedePermanecerEnLaGuarderia unaRutina unPerro = realizarEjercicios unaRutina unPerro 
    | otherwise = unPerro

--
realizarEjercicios :: Rutina -> ModificarPerro
realizarEjercicios unaRutina unPerro = foldr ($) unPerro.ejercicios $ unaRutina 
--

quedaronCansados :: Rutina -> [Perro] -> [Perro]
quedaronCansados unaRutina = filter (quedoCansadoDespuesDeLaRutina unaRutina) 

quedoCansadoDespuesDeLaRutina :: Rutina -> EvaluarPerro
quedoCansadoDespuesDeLaRutina unaRutina unPerro = ((< 5).energia.realizarEjercicios unaRutina $ unPerro) && puedePermanecerEnLaGuarderia unaRutina unPerro

-- P.3 

perroPi :: Perro 
perroPi = UnPerro {
    raza = "Labrador",
    juguetesFavoritos = map juguetePerroPi [1..],
    tiempoEnLaGuarderia = 314,
    energia = 159
}

juguetePerroPi :: Int -> Juguete 
juguetePerroPi unNumero = "Soguita " ++ show unNumero 

tieneUnJuguete :: Juguete -> EvaluarPerro
tieneUnJuguete unJuguete = elem unJuguete.juguetesFavoritos

{-

¿Sería posible saber si Pi es de una raza extravagante?

Consulta: esDeRazaExtravagante.raza $ perroPi 
Gracias a no tener que evaluar la lista completa debido al lazy evaluation, la funcion retorna false.

¿Qué pasa si queremos saber si Pi tiene…
… algún huesito como juguete favorito? 
Consulta: tieneUnJuguete "Huesito" perroPi
… alguna pelota luego de pasar por la Guardería de Perritos?
Consulta: tieneUnJuguete "Pelota" perroPi
… la soguita 31112?
Consulta: tieneUnJuguete "Soguita 31112" perroPi

Para todos estos casos existen dos posibles caminos. Si el juguete pertenece a los juguetes favoritos de perroPi entonces la funcion tarde o temprano devolvera True, 
esto es posible gracias al lazy evaluation, que teniendo en cuenta como funciona elem la funcion puede retornar True sin evaluar la lista completa. Por otra parte, si 
el juguete no pertenece a la lista de juguetes favoritos de perroPi lo que sucedera es que elem se quedara realizanco comparaciones infinitamente, debido a que debe
evaluar todos los elementos de la lista para poder retornar false, y al ser infinitos es imposible.

¿Es posible que Pi realice una rutina?

Consulta: realizarRutina guarderiaPdePerritos perroPi
Al tener un tiempo mayor al de la rutina (y poder comprobarse mediante puedeRealizarLaRutina debido al lazy evaluation), perroPi puede realzar una rutina, sin embargo
podremos ver los resultados de esa rutina unicamente si la lista de juguetes es el ultimo elemento del data, dado que cuando llegue el momento de mostrar en pantalla
la lista se quedara emitiendola infinitamente imposibilitando ver el resto de datos.  

¿Qué pasa si le regalamos un hueso a Pi?

Consulta: regalar "Hueso" perroPi 
Esto unicamente es posible si el hueso se lo agrega al principio de la lista, dado que posee un primer elemento pero no posee un ultimo elemento, por lo tanto nunca
podria agregarlo.

-}