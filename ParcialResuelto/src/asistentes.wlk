import src.excepcionSaldoNegativo.ExcepcionSaldoNegativo
import src.entrada.Entrada

class Asistente {
    
    var tipoDeAbono
    var historialDeEntradas = []
    var dineroDisponible

    method comprarEntrada(unaBanda,unaFecha) {
     
        if(dineroDisponible > 0) {
            
            const unaEntrada = new Entrada (banda = unaBanda,fechaQueToca = unaFecha)
            historialDeEntradas.add(unaEntrada)
            dineroDisponible -= tipoDeAbono.precioDeLaEntrada(unaEntrada)
        } else {
            
            throw new ExcepcionSaldoNegativo(message = "No se puede comprar una entrada con saldo negativo")
        }
    }

    method entradasDelAnioAnterior() = historialDeEntradas.filter({unaEntrada => unaEntrada.esDelAnioAnterior()})

    method deQueBandasTieneEntrada() = historialDeEntradas.forEach({unaEntrada => unaEntrada.nombreDeLaBanda()}).asSet()

    method cambiarAbono(unAbono) {
        tipoDeAbono = unAbono
    }

    method recaudacion() = historialDeEntradas.sum({unaEntrada => unaEntrada.precio()})

    method cantidadDeEntradasVendidas() = historialDeEntradas.size()
}
