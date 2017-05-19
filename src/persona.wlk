import excepcion.*

class Persona{
	
	var nombre
	var edad
	var cantHorasTrabajadas=0
	var habilidad
	
	constructor(_nombre,_edad,_habilidad){
		nombre=_nombre
		edad=_edad
		habilidad=_habilidad
	}
	
	method cantHorasTrabajadas()=cantHorasTrabajadas
	
	method aumentarHoras(horas){
		cantHorasTrabajadas+=habilidad.contabilizarHora(horas)
	}
	
	method cumplisRangoDeEdad(){
		
		if (edad<18){
			throw new UserException("Persona menor de 18 años, no puede trabajar")
		}
		if (edad>65){
			throw new UserException("Persona mayor de 65 años, no puede trabajar")
		}
	}
	
	//----------------punto2-------------------------------------
	method trabajar(horas,unaPropiedad){
		try{
			self.cumplisRangoDeEdad()
			self.aumentarHoras(horas)
			unaPropiedad.descontarHoras(habilidad.contabilizarHora(horas))
		} catch e: UserException{
			self.mostrarMensajeDeAdvertencia(e.getMessage())
		}
		
	}
	
	method mostrarMensajeDeAdvertencia(_mensaje){
		throw new UserException(_mensaje)
	}
	
}