import src.productora.productora
class Entrada {

    const banda 
    const fechaQueToca

    method precio() = 1000 + productora.impuestosDeLasEntradas()

    method esDelAnioAnterior() = calendar.today().year() == calendar.today().year() - 1

    method nombreDeLaBanda() = banda.nombre()
}