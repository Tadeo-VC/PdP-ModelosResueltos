import src.excepcionUnaEstrellaNoSePuedeRecategorizar.ExcepcionUnaEstrellaNoSePuedeRecategorizar

class Actor 
{
    var experiencia
    var peliculasEnLasQueActuo
    var ahorros

    method sueldo() = experiencia.cuantoCobra(self)

    method peliculasEnLasQueActuo() = peliculasEnLasQueActuo

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

        if(unActor.nivelDeFamaMayorA(unActor,14)) {
            
            return 5000 * unActor
        } else {

            return 15000
        }
    }

    method subirDeCategoria(unActor) {

        if(unActor.nivelDeFamaMayorA(unActor,10)) {
            unActor.experiencia(estrella) 
        }
    }

    method nivelDeFama(unActor) = unActor.peliculasEnLasQueActuo() / 2

    method nivelDeFamaMayorA(unActor,unaCantidad) = self.nivelDeFama(unActor) > unaCantidad
}
object estrella 
{
    method cuantoCobra(unActor) = unActor.peliculasEnLasQueActuo() * 30000

    method subirDeCategoria(unActor) = throw new ExcepcionUnaEstrellaNoSePuedeRecategorizar()
}