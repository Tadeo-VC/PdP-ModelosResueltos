import src.eventos.Evento
class Nena 
{
    var felicidad
    var emocionDominante // Composicion
    var recuerdosDelDia          
    const pensamientosCentrales // set
    const memoriaLargoPlazo

    method emocionDominante(unaEmocion)
    {
        emocionDominante = unaEmocion
    } 

    method vivirEvento(unNombre, unaDescripcion) 
    {
        const evento = new Evento(descripcion = unaDescripcion, fecha = new Date(), emocionDominanteDelMomento = emocionDominante)
        recuerdosDelDia.add(evento)  
    }

    method asentarRecuerdo(unRecuerdo) 
    {
        if(self.existeElRecuerdo(unRecuerdo)) {
            unRecuerdo.asentarRecuerdo(self, unRecuerdo)
        }
    }

    method reducirFelicidadPorcentual(unPorcentajeEnDecimal)
    {
        const auxiliar = felicidad
        felicidad = 1.max(felicidad * (1 - unPorcentajeEnDecimal))

        //if(felicidad < 1) 
        //{
            // excepcion
        //}
    }

    method ultimosRecuerdosDelDia() = recuerdosDelDia.take(5)

    method pensamientosCentrales() = pensamientosCentrales

    method pensamientosDificilesDeExplicar() = pensamientosCentrales.filter({unRecuerdo => unRecuerdo.esDificilDeExplicar()})
    
    //

    method asentarRecuerdos() = self.filtrarRecuerdosDelDia({unRecuerdo => self.asentarRecuerdo(unRecuerdo)})

    method asentamientoSelectivo(unaPalabra) = self.filtrarRecuerdosDelDia({unRecuerdo => self.asentarSelectivamente(unRecuerdo, unaPalabra)})

    method profundizacion() = memoriaLargoPlazo.union(self.recuerdosParaLargoPlazo().forEach({unRecuerdo => unRecuerdo.enviarALargoPlazo()}))

    method controlHormonal() 
    {
        if(self.unPensamientoCentralEstaEnLargoPlazo() || self.todosLosRecuerdosTienenLaMismaEmocion())
        {
            self.desequilibrioHormonal()
        }
    }

    method restauracionCognitiva(unaCantidad) 
    {
        if(unaCantidad <= 100)
        {
            felicidad = (felicidad + unaCantidad).min(1000)
        }
    }

    method liberarRecuerdos() 
    {
        recuerdosDelDia = []
    }

    method irADormir(unaCantidad)
    {
        self.asentarRecuerdos()
        self.profundizacion()
        self.controlHormonal()
        self.restauracionCognitiva(unaCantidad)
        self.liberarRecuerdos()
    }

    //


    //

    method existeElRecuerdo(unRecuerdo) = recuerdosDelDia.contains(unRecuerdo)

    method agregarPensamientoCentral(unRecuerdo) = pensamientosCentrales.add(unRecuerdo)

    method filtrarRecuerdosDelDia(unBloque) = recuerdosDelDia.filter(unBloque)

    method asentarSelectivamente(unRecuerdo, unaPalabraClave) 
    {
        if(unRecuerdo.tieneLaPalabraClave(unaPalabraClave))
        {
            self.asentarRecuerdo(unRecuerdo)
        }
    }

    method recuerdosParaLargoPlazo() = self.filtrarRecuerdosDelDia({unRecuerdo => self.aceptaElRecuerdo(unRecuerdo)})

    method aceptaElRecuerdo(unRecuerdo) = not(pensamientosCentrales.contains(unRecuerdo) && emocionDominante.aceptaElRecuerdo(unRecuerdo)) 

    method desequilibrioHormonal() 
    {
        self.reducirFelicidadPorcentual(0.15)
        self.perderPensamientosCentralesAntiguos(3)
    }

    method perderPensamientosCentralesAntiguos(unaCantidad) = pensamientosCentrales.take(pensamientosCentrales.size() - unaCantidad)

    method unPensamientoCentralEstaEnLargoPlazo() = pensamientosCentrales.any({unPensamiento => memoriaLargoPlazo.contains(unPensamiento)})

    method todosLosRecuerdosTienenLaMismaEmocion() 
    { 
        const emociones = recuerdosDelDia.map({unRecuerdo => unRecuerdo.emocionDominanteDelMomento()})
        return emociones.all({unaEmocion => unaEmocion == emociones.take(1)})
    }
}