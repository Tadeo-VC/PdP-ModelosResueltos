import emociones.*

class Evento
{
    const descripcion
    const fecha
    const emocionDominanteDelMomento

    method emocionDominanteDelMomento() = emocionDominanteDelMomento

    method asentarRecuerdo(unaNena, unRecuerdo) = emocionDominanteDelMomento.comoAsentarRecuerdo(unaNena, unRecuerdo)

    method esDificilDeExplicar() = descripcion.size() > 10

    method tieneLaPalabraClave(unaPalabraClave) = descripcion.contains(unaPalabraClave)

    method esRecuerdoAlegre() = emocionDominanteDelMomento.esAlegre()
}