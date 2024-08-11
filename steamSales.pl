juego(accion(callOfDuty),5).
juego(accion(batmanAA),10).
juego(mmorpg(wow,5000000),30).
juego(mmorpg(lineage2,6000000),15). 
juego(puzzle(plantsVsZombies,40,media),10).
juego(puzzle(tetris,10,facil),0).

oferta(callOfDuty,60).
oferta(plantsVsZombies,80).

usuario(nico,[batmanAA,callOfDuty,plantsVsZombies,tetris],[compra(lineage2)]).
usuario(fede,[],[regalo(callOfDuty,nico),regalo(wow,nico)]).
usuario(rasta,[lineage2],[]).
usuario(agus,[],[]).
usuario(felipe,[plantsVsZombies],[compra(tetris)]).

% PUNTO 1

cuantoSale(Juego, Precio):-
    juego(Juego, PrecioSinDescuento),
    nombreDelJuego(Juego, NombreDelJuego),
    oferta(NombreDelJuego, PorcentajeDeDescuento),
    Precio is PrecioSinDescuento - (PrecioSinDescuento / 100) * PorcentajeDeDescuento.

cuantoSale(Juego, Precio):-
    juego(Juego, Precio),
    nombreDeLaCompra(Juego, NombreDelJuego),
    not(oferta(NombreDelJuego, _)).

nombreDelJuego(accion(NombreDelJuego), NombreDelJuego):-
    juego(accion(NombreDelJuego), _).
nombreDelJuego(mmorpg(NombreDelJuego, _), NombreDelJuego):-
    juego(mmorpg(NombreDelJuego, _), _).
nombreDelJuego(puzzle(NombreDelJuego, _, _), NombreDelJuego):-
    juego(puzzle(NombreDelJuego, _, _), _).
nombreDeLaCompra(compra(NombreDelJuego), NombreDelJuego).
nombreDeLaCompra(regalo(NombreDelJuego, _), NombreDelJuego).

% PUNTO 2

juegoPopular(accion(Nombre)):-
    juego(accion(Nombre), _).

juegoPopular(mmorpg(Nombre, CantidadDeUsuarios)):-
    juego(mmorpg(Nombre, CantidadDeUsuarios), _),
    CantidadDeUsuarios > 1000000.

juegoPopular(puzzle(Nombre, 25, Dificultad)):-
    juego(puzzle(Nombre, 25, Dificultad), _).

juegoPopular(puzzle(Nombre, CantidadDeNiveles, facil)):-
    juego(puzzle(Nombre, CantidadDeNiveles, facil), _).

% PUNTO 3

tieneBuenDescuento(Juego):-
    juego(Juego, _),
    nombreDelJuego(Juego, NombreDelJuego),
    oferta(NombreDelJuego, Descuento),
    Descuento > 50.

% PUNTO 4 

adictoALosDescuentos(Usuario):-
    usuario(Usuario, _, JuegosAAdquirir),
    JuegosAAdquirir \= [],
    forall(member(JuegoAAdquirir, JuegosAAdquirir), compraConBuenDescuento(JuegoAAdquirir)).

compraConBuenDescuento(JuegoAAdquirir):-
    nombreDeLaCompra(JuegoAAdquirir, NombreDelJuego),
    nombreDelJuego(Juego, NombreDelJuego),
    tieneBuenDescuento(Juego).

% PUNTO 5

fanaticoDe(Usuario,Genero):-
    usuario(Usuario, Juegos, _),
    member(NombreDeUnJuego, Juegos),
    member(NombreDeOtroJuego, Juegos),
    NombreDeUnJuego \= NombreDeOtroJuego,
    genero(NombreDeUnJuego, Genero),
    genero(NombreDeOtroJuego, Genero).

genero(NombreDelJuego, Genero):-
    juego(Juego,_),
    nombreDelJuego(Juego, NombreDelJuego),
    generoDelJuego(Juego, Genero).

generoDelJuego(accion(_),accion).
generoDelJuego(mmorpg(_, _),mmorpg).
generoDelJuego(puzzle(_, _, _), puzzle).

% PUNTO 6 

monotematico(Usuario, Genero):-
    usuario(Usuario, Juegos, _),
    Juegos \= [],
    generoDelJuego(_,Genero),
    forall(member(NombreDelJuego, Juegos), genero(NombreDelJuego, Genero)).

% PUNTO 7

buenosAmigos(UnUsuario, OtroUsuario):-
   regalaA(UnUsuario, OtroUsuario, UnJuego),
   regalaA(OtroUsuario, UnUsuario, OtroJuego),
   juegoPopular(UnJuego),
   juegoPopular(OtroJuego).

regalaA(UnUsuario, OtroUsuario, Juego):-
    usuario(UnUsuario, _, JuegosAAdquirir),
    usuario(OtroUsuario, _, _),
    member((regalo(NombreDelJuego, OtroUsuario)), JuegosAAdquirir),
    nombreDelJuego(Juego, NombreDelJuego).
    
cuantoGastara(Usuario, InversionEnFelicidad):-
    usuario(Usuario, _, JuegosAAdquirir),
    gasto(JuegosAAdquirir, 0, InversionEnFelicidad).

gasto([ UnJuego | RestoDeJuegos ], AcumuladorDeFelicidad, InversionEnFelicidad):-
    precioDeLaCompra(UnJuego, Inversion),
    NuevoAcumuladorDeFelicidad is AcumuladorDeFelicidad + Inversion,
    gasto(RestoDeJuegos, NuevoAcumuladorDeFelicidad, InversionEnFelicidad).
gasto([], AcumuladorDeFelicidad, AcumuladorDeFelicidad).

precioDeLaCompra(JuegoAAdquirir, Precio):-
    nombreDeLaCompra(JuegoAAdquirir, NombreDelJuego),
    nombreDelJuego(Juego, NombreDelJuego),
    cuantoSale(Juego, Precio).