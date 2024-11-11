
class Banda {
    
    const nombre 
    const canonBase = 1000000

    method presupuesto() = self.canon() + self.gastoExtra()

    method gastoExtra() 

    method popularidad()

    method canon() = canonBase

    method nombre() = nombre 
}
class BandaDeRock inherits Banda {

    const cantidadDeSolosDeGuitarra

    override method gastoExtra() = 10000

    override method popularidad() =  100 * cantidadDeSolosDeGuitarra
}
class BandaDeTrap inherits Banda {

    const tienenHielo // booleano 

    override method gastoExtra() = 0

    override method popularidad() {

        if(tienenHielo) {
            return 1000
        } else {
            return 0
        }
    }

    override method canon() = canonBase * self.popularidad()
}
class BandaDeIndie inherits Banda {

    const cantidadDeInstrumentos

    override method popularidad() = nombre.size() * 3.14

    override method presupuesto() = 500 * cantidadDeInstrumentos
}
