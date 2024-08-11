personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([forequiereInteractuarForceFive])).
personaje(butch,      borequiereInteractuareador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules,   jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

% PUNTO 1

esPeligroso(Personaje):-
    realizaActividadPeligrosa(Personaje).
esPeligroso(Personaje):-
    distinct(Personaje, trabajaPara(Personaje, OtroPersonaje)),
    realizaActividadPeligrosa(OtroPersonaje).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, mafioso(maton)).
realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, ladron(LugaresAsaltados)),
    member(licorerias, LugaresAsaltados).

% PUNTO 2

duoPeligroso(UnPersonaje,OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    tienenUnaRelacion(UnPersonaje, OtroPersonaje).

tienenUnaRelacion(UnPersonaje, OtroPersonaje):-
    amigo(UnPersonaje, OtroPersonaje).
tienenUnaRelacion(UnPersonaje, OtroPersonaje):-
    amigo(OtroPersonaje, UnPersonaje).
tienenUnaRelacion(UnPersonaje, OtroPersonaje):-
    pareja(UnPersonaje, OtroPersonaje).
tienenUnaRelacion(UnPersonaje, OtroPersonaje):-
    amigo(OtroPersonaje, UnPersonaje).

% PUNTO 3

estaEnProblemas(Personaje):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    distinct(Personaje, encargo(Jefe, Personaje, cuidar(Pareja))),
    pareja(Jefe, Pareja).

estaEnProblemas(Personaje):-
    distinct(Personaje, encargo(_, Personaje, buscar(OtroPersonaje, _))),
    personaje(OtroPersonaje, borequiereInteractuareador).

estaEnProblemas(butch).

% PUNTO 4

sanCayetano(Personaje):-
    distinct(Personaje,genteCercana(Personaje, _)),
    forall(genteCercana(Personaje, PersonajeCercano), leDaTrabajo(Personaje, PersonajeCercano)).

genteCercana(Personaje, PersonajeCercano):-
    amigo(Personaje, PersonajeCercano).
genteCercana(Personaje, PersonajeCercano):-
    encargo(Personaje, PersonajeCercano, _).

leDaTrabajo(Personaje, OtroPersonaje):-
    trabajaPara(Personaje, OtroPersonaje).
leDaTrabajo(Personaje, OtroPersonaje):-
    encargo(Personaje, OtroPersonaje, _).

% PUNTO 5

masAtareado(Personaje):- 
    distinct(Personaje, encargos(Personaje, _, CantidadDeEncargosMayor)),
    forall(cantidadDeEncargosDeOtro(_, Personaje, CantidadDeEncargosDeOtro), CantidadDeEncargosMayor > CantidadDeEncargosDeOtro).

cantidadDeEncargosDeOtro(OtroPersonaje,Personaje,CantidadDeEncargos):-
    encargos(OtroPersonaje, _, CantidadDeEncargos), 
    OtroPersonaje \= Personaje.

encargos(Personaje, Encargos, CantidadDeEncargos):-
    distinct(Personaje,encargo(_, Personaje, _)),
    findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
    length(Encargos, CantidadDeEncargos).

masAtareado2(Personaje):-
    distinct(Personaje,encargo(_, Personaje, _)),
    tieneMasEncargos(Personaje, _).

tieneMasEncargos(Personaje, OtroPersonaje):- 
    distinct(Personaje, encargos(Personaje, _, CantidadDeEncargosMayor)),
    distinct(OtroPersonaje, encargos(OtroPersonaje, _, CantidadDeEncargosMenor)),
    Personaje \= OtroPersonaje,
    CantidadDeEncargosMayor > CantidadDeEncargosMenor.

% PUNTO 6

respeto(Personaje, Respeto):-
    personaje(Personaje, actriz(Peliculas)),
    length(Peliculas, CantidadDePeliculas),
    Respeto is CantidadDePeliculas / 10.
respeto(Personaje, 1):-
    personaje(Personaje, mafioso(maton)).
respeto(Personaje, 10):-
    personaje(Personaje, mafioso(resuelveProblemas)).
respeto(Personaje, 20):-
    personaje(Personaje, mafioso(capo)).

personajesRespetables(PersonajesRespetables):-
    findall(Personaje, esRespetable(Personaje), PersonajesRespetables).

esRespetable(Personaje):-
    respeto(Personaje, Respeto),
    Respeto > 9.

% PUNTO 7

hartoDe(Personaje, OtroPersonaje):-
    encargos(Personaje, Encargos, _),
    personaje(OtroPersonaje, _),
    forall(member(Tarea, Encargos), requiereInteractuar(Tarea, OtroPersonaje)).

requiereInteractuar(cuidar(OtroPersonaje), OtroPersonaje).
requiereInteractuar(cuidar(Amigo), OtroPersonaje):-
    amigo(OtroPersonaje, Amigo).
requiereInteractuar(ayudar(OtroPersonaje), OtroPersonaje).
requiereInteractuar(ayudar(Amigo), OtroPersonaje):-
    amigo(OtroPersonaje, Amigo).
requiereInteractuar(buscar(OtroPersonaje, _), OtroPersonaje).
requiereInteractuar(buscar(Amigo, _), OtroPersonaje):-
    amigo(OtroPersonaje, Amigo).

hartoDe2(Personaje, OtroPersonaje):-
    encargo(_, Personaje, _),
    personaje(OtroPersonaje, _).
    forall(encargo(_, Personaje, Encargo),requiereInteractuar(Encargo, OtroPersonaje)).

% PUNTO 8

duoDiferenciable(PersonajeA, PersonajeB):-
    tienenUnaRelacion(PersonajeA, PersonajeB),
    caracteristicas(PersonajeA, CaracteristicasA),
    caracteristicas(PersonajeB, CaracteristicasB),
    member(Caracteristica, CaracteristicasA),
    not(member(Caracteristica, CaracteristicasB)).

/* NO FUNCIONA PORQUE PARA QUE SEAN IGUALES TIENEN QUE ESTAR EN EL MISMO ORDEN
duoDiferenciable2(PersonajeA, PersonajeB):-
    tienenUnaRelacion(PersonajeA, PersonajeB),
    caracteristicas(PersonajeA, CaracteristicasA),
    caracteristicas(PersonajeB, CaracteristicasB),
    CaracteristicasA \= CaracteristicasB.
*/