
object productora {

    const bandas = []
    const asistentes = []
    var impuestoDeLasEntradas = 0 

    method gananciaTotal() = self.recaudacionDeAsistentes() - self.presupuestoDeLasBandas()

    method recaudacionDeAsistentes() = asistentes.sum({unAsistente => unAsistente.recaudacion()})
    method presupuestoDeLasBandas() = bandas.sum({unaBanda => unaBanda.presupuesto()})

    method cantidadDeEntradasVendidas() = asistentes.sum({unAsistente => unAsistente.cantidadDeEntradasVendidas()})

    method bandaMasPopular() = bandas.max({unaBanda => unaBanda.popularidad()})

    method bonificarAsistentesVIP() = asistentes.map({unAsistente => unAsistente.bonificar()})

    method impuestosDeLasEntradas() = impuestoDeLasEntradas
    method impuestoDeLasEntradas(unValor) {
        impuestoDeLasEntradas = unValor
    }
}