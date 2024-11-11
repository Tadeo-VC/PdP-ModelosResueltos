
object fan {

    method precioDeLaEntrada(unaEntrada) = unaEntrada.precio()
}

class Vip {

    var porcentajeDeDescuento // [0,1]

    method precioDeLaEntrada(unaEntrada) = unaEntrada.precio() * (1 - porcentajeDeDescuento)

    method bonificar() {
        porcentajeDeDescuento += 0.01
    }
}