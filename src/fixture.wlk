import tipoPropiedad.*
import persona.*
import familia.*

object fixture {

	method crearCasa(cantHorasTrabajoRestante, cantHorasPorFamilia,ambientes){		
		return new Casa(cantHorasTrabajoRestante, cantHorasPorFamilia, ambientes)
	}
	
	method crearDepto(cantHorasTrabajoRestante, cantHorasPorFamilia, superficie){		
		return new Departamento(cantHorasTrabajoRestante, cantHorasPorFamilia, superficie)
	}
	
	method crearPersona(nombre, edad, habilidad){		
		return new Persona(nombre, edad, habilidad)
	}
	
	method crearFamilia(){
		return new Familia()
	}

}