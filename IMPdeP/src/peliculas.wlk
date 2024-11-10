
class Pelicula
{
    const nombre
    const elenco
    
    method presupuesto() = self.sueldoDelElenco() * 1.70

    method sueldoDelElenco() = elenco.sum({unActor => unActor.sueldo()})
    
    method ganancias() = self.recaudacion() - self.ganancias()
    
    method recaudacion() = 1000000 + self.recaudacionExtra()

    method recaudacionExtra()

    method rodarPelicula() = elenco.forEach({unActor => unActor.actuar()})

    method esEconomica() = self.presupuesto() < 500000
}

class PeliculaDeDrama inherits Pelicula
{
    override method recaudacionExtra() = self.recaudacionPorNombre()

    method recaudacionPorNombre() = nombre.size() * 100000
}

class PeliculaDeAccion inherits Pelicula
{
    const vidriosRotos
    
    override method presupuesto() = super() + 1000 * vidriosRotos

    override method recaudacionExtra() = self.recaudacionPorElenco()

    method recaudacionPorElenco() = elenco.size() * 50000
}

class PeliculaDeTerror inherits Pelicula
{
    const cuchos 

    override method recaudacionExtra() = 20000 * cuchos
}

class PeliculaDeComedia inherits Pelicula 
{
    override method recaudacionExtra() = 0 // si no creaba el metodo abstracto recaudacion extra y dejaba todo en presupuesto esta clase no tenia sentido
}
