import src.excepcionUnaEstrellaNoSePuedeRecategorizar.ExcepcionUnaEstrellaNoSePuedeRecategorizar

class Actor 
{
    var experiencia
    const nivelDeFama
    var peliculasEnLasQueActuo
    var ahorros

    method sueldo() = experiencia.cuantoCobra(self)

    method peliculasEnLasQueActuo() = peliculasEnLasQueActuo

    method nivelDeFamaMayorA(unaCantidad) = nivelDeFama > unaCantidad

    method recategorizarse() = experiencia.subirDeCategoria()

    method experiencia(unaCategoria) {
        experiencia = unaCategoria
    }

    method actuar() {
        peliculasEnLasQueActuo += 1
        ahorros += self.sueldo()
    }
}

object amateur
{
    method cuantoCobra(unActor) = 10000

    method subirDeCategoria(unActor) {

        if(unActor.peliculasEnLasQueActuo() > 10) {
            unActor.experiencia(establecido) 
        }
    }
}

object establecido 
{
    method cuantoCobra(unActor) {

        if(unActor.nivelDeFamaMayorA(14)) {
            
            return 5000 * unActor
        } else {

            return 15000
        }
    }

    method subirDeCategoria(unActor) {

        if(unActor.nivelDeFamaMayorA(10)) {
            unActor.experiencia(estrella) 
        }
    }
}
object estrella 
{
    method cuantoCobra(unActor) = unActor.peliculasEnLasQueActuo() * 30000

    method subirDeCategoria(unActor) = throw new ExcepcionUnaEstrellaNoSePuedeRecategorizar()
}