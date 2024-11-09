
class Emocion
{
    method comoAsentarRecuerdo(unaNena, unRecuerdo) {}

    method aceptarElRecuerdo(unRecuerdo) = true

    method esAlegre() = false
}

object alegria inherits Emocion
{
    override method comoAsentarRecuerdo(unaNena, unRecuerdo) 
    {
        if(unaNena.suFelicidadEsMayorA(500)) 
        {
            unaNena.agregarPensamientoCentral(unRecuerdo)
        }
    }

    override method aceptarElRecuerdo(unRecuerdo) = unRecuerdo.esRecuerdoAlegre()

    override method esAlegre() = true
}

object tristeza inherits Emocion
{
    override method comoAsentarRecuerdo(unaNena, unRecuerdo) 
    {
        unaNena.agregarPensamientoCentral(unRecuerdo)
        unaNena.reducirFelicidadPorcentual(0.1)
    }

    override method aceptarElRecuerdo(unRecuerdo) = not(unRecuerdo.esRecuerdoAlegre())

    override method esAlegre() = false
}

const disgusto = new Emocion()

const furia = new Emocion()

const temor = new Emocion()

class EmocionCompuesta
{
    const emociones

    method comoAsentarElRecuerdo(unaNena, unRecuerdo) = emociones.forEach({unaEmocion => unaEmocion.comoAsentarElRecuerdo(unaNena, unRecuerdo)})

    method aceptarElRecuerdo(unRecuerdo) = self.algunaEmocion({unaEmocion => unaEmocion.aceptarElRecuerdo(unRecuerdo)})

    method esAlegre() = self.algunaEmocion({unaEmocion => unaEmocion.esAlegre()})

    method algunaEmocion(unBloque) = emociones.any(unBloque)
}