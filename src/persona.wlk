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
	
	method cumplisRango(){
		return edad>=18 && edad<=65
	}
	
	//----------------punto2-------------------------------------
	method podesTrabajar(horas,propiedad){		
		if(self.cumplisRango()){
			
			self.aumentarHoras(horas)
			propiedad.descontarHoras(habilidad.contabilizarHora(horas))		
		} else{
			
			throw new UserException("No puedo trabajar")
		}
		
	}
	
}