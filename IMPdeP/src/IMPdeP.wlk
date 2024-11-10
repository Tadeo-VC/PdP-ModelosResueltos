
object IMPdeP 
{
    const peliculas = []
    const actores = []

    method actorMejorPago() = actores.max({unActor => unActor.sueldo()}) 

    method peliculasEconomicas() = peliculas.filter({unaPelicula => unaPelicula.esEconomica()})

    method nombresDePeliculasEconomicas() = self.peliculasEconomicas().map({unaPelicula => unaPelicula.nombre()})

    method gananciaDePeliculasEconomicas() = self.peliculasEconomicas().sum({unaPelicula => unaPelicula.ganancia()})

    method recategorizarActores() = actores.forEach({unActor => unActor.recategorizarse()})
}