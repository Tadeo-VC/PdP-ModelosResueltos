%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).

%peso(Personaje, Peso)
peso(pumba, 100). % + 83
peso(timon, 50).  % + 17
peso(simba, 200). % + 10

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

persigue(scar, mufasa).

% PUNTO 1

jugosita(cucaracha(Nombre, Tamanio, UnPeso)):-
    comio(_, cucaracha(Nombre, Tamanio, UnPeso)),
    comio(_, cucaracha(_, Tamanio, OtroPeso)),
    UnPeso \= OtroPeso,
    not((comio(_, cucaracha(_, Tamanio, OtroPeso)), OtroPeso > UnPeso)).

hormigofilico(Personaje):-
    comio(Personaje, hormiga(UnNombre)),
    comio(Personaje, hormiga(OtroNombre)),
    UnNombre \= OtroNombre.

hormigofilico1(Personaje):-
    distinct(Personaje, comio(Personaje, hormiga(_))),
    findall(Nombre, comio(Personaje, hormiga(Nombre)), Hormigas),
    length(Hormigas, CantidadDeHormigas),
    CantidadDeHormigas > 1.

cucarachofobico(Personaje):-
    distinct(Personaje, comio(Personaje, _)),
    not(comio(Personaje, cucaracha(_, _, _))).

picarones(Personajes):-
    findall(Personaje, esPicaron(Personaje), Personajes).

esPicaron(Personaje):-
    comio(Personaje, cucaracha(Nombre, Tamanio, Peso)),
    jugosita(cucaracha(Nombre, Tamanio, Peso)).

esPicaron(Personaje):-
    comio(Personaje, vaquitaSanAntonio(remeditos,_)).

% PUNTO 2 , 3 Y 4
/*
cuantoEngorda(Personaje, KilosDeMas):-
    distinct(Personaje, comio(Personaje, _)),
    kilosPorComerCucarachas(Personaje, KilosDeCucarachas),
    kilosPorComerVaquitas(Personaje, KilosDeVaquitas),
    kilosPorComerHormigas(Personaje, KilosDeHormigas),
    kilosPorCazar(Personaje, KilosDeCazar),
    KilosDeMas is KilosDeCucarachas + KilosDeHormigas + KilosDeVaquitas + KilosDeCazar.

kilosPorComerCucarachas(Personaje, KilosDeCucarachas):-
    distinct(Personaje, comio(Personaje, cucaracha(_, _, _))),
    findall(Peso, comio(Personaje, cucaracha(_, _, Peso)), PesoPorCucaracha),
    sum_list(PesoPorCucaracha, KilosDeCucarachas).
kilosPorComerCucarachas(Personaje, 0):-
    distinct(Personaje, comio(Personaje, _)),
    not(comio(Personaje, cucaracha(_, _, _))).

kilosPorComerVaquitas(Personaje, KilosDeVaquitas):-
    distinct(Personaje, comio(Personaje, vaquitaSanAntonio(_, _))),
    findall(Peso, comio(Personaje, vaquitaSanAntonio(_, Peso)), PesoPorVaquita),
    sum_list(PesoPorVaquita, KilosDeVaquitas).   
kilosPorComerVaquitas(Personaje, 0):-
    distinct(Personaje, comio(Personaje, _)),
    not(comio(Personaje, vaquitaSanAntonio(_, _))).

kilosPorComerHormigas(Personaje, KilosDeHormigas):-
    distinct(Personaje, comio(Personaje, hormiga(_))),
    pesoHormiga(Peso),
    findall(Peso, comio(Personaje, hormiga(_)), Hormigas),
    sum_list(Hormigas, KilosDeHormigas).
kilosPorComerHormigas(Personaje, 0):-
    distinct(Personaje, comio(Personaje, _)),
    not(comio(Personaje, hormiga(_))).

kilosPorCazar(Personaje, KilosDeCazar):-    
    distinct(Personaje, persigue(Personaje, _)),
    findall(Peso, pesoDeLasPresas(Personaje, Peso), PesoPorPresa),
    sum_list(PesoPorPresa, KilosDeCazar).
kilosPorCazar(Personaje, 0):-
    distinct(Personaje, comio(Personaje, _)),
    not(persigue(Personaje, _)).

pesoDeLasPresas(Personaje, Peso):-
    persigue(Personaje, Presa), 
    peso(Presa, Peso).
*/
%

cuantoEngorda(Personaje, KilosDeMas):-
    distinct(Personaje, peso(Personaje, _)),
    kilosDeInsectos(Personaje, cucaracha(_, _, Peso), KilosDeCucarachas),
    kilosDeInsectos(Personaje, hormiga(_), KilosDeHormigas),
    kilosDeInsectos(Personaje, vaquitaSanAntonio(_, Peso), KilosDeVaquitas),
    kilosDeCaza(Personaje, KilosDeCazar),
    KilosDeMas is KilosDeCucarachas + KilosDeHormigas + KilosDeVaquitas + KilosDeCazar.

kilosDeInsectos(Personaje, TipoDeComida, Kilos):-
    findall(Peso, pesoPorComida(Personaje, TipoDeComida, Peso), PesoPorComida),
    sum_list(PesoPorComida, Kilos).
kilosDeInsectos(Personaje, TipoDeComida, 0):-
    comio(Personaje, _),
    not(comio(Personaje, TipoDeComida)).

pesoPorComida(Personaje, TipoDeComida, Peso):-
    comio(Personaje, TipoDeComida), 
    pesoPorTipo(TipoDeComida, Peso).

pesoPorTipo(cucaracha(_,_,Peso), Peso):-
    pesoCucaracha(cucaracha(_, _, Peso), Peso).

pesoPorTipo(vaquitaSanAntonio(_, Peso), Peso):-
    pesoPorVaquita(vaquitaSanAntonio(_, Peso), Peso).

pesoPorTipo(hormiga(_), Peso):-
    pesoHormiga(Peso).

pesoCucaracha(cucaracha(_, _, Peso), Peso).
pesoPorVaquita(vaquitaSanAntonio(_, Peso), Peso).

kilosDeCaza(Personaje ,Kilos):-
    persigue(Personaje, _),
    findall(Peso, pesoPorPresa(Personaje, _, Peso), PesoPorPresa),
    sum_list(PesoPorPresa, Kilos).

kilosDeCaza(Personaje, 0):-
    peso(Personaje, _),
    not(persigue(Personaje, _)).
    
pesoPorPresa(Personaje, Presa, Peso):-
    persigue(Personaje, Presa),
    peso(Presa, PesoBase),
    distinct(Presa, cuantoEngorda(Presa, PesoAdicional)),
    Peso is PesoBase + PesoAdicional.

% PUNTO 5 

elRey(Rey):-
    persigue(AspiranteAlTrono, Rey),
    not((persigue(OtroAspirante, Rey), OtroAspirante \= AspiranteAlTrono)),
    not(persigue(Rey, _)),
    not(comio(Rey, _)).