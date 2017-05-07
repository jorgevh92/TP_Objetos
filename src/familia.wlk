
class Familia {

	const personas=[]
	
	method agregarPersona(persona){
		personas.add(persona)	
	}
	
	method cantIntegrantes()=return personas.size()
	
	//---------Punto3--------------------------------
	method estasHabilitada(propiedad){
		
		return propiedad.sosHabitable() && self.superasHorasTrabajadas(propiedad) && propiedad.personasSoportadas()>self.cantIntegrantes()+1		
	}
	
	method horasTrabajadas() {	
		return personas.sum({persona => persona.cantHorasTrabajadas()})
	}
	
	method superasHorasTrabajadas(propiedad){
		return self.horasTrabajadas() > propiedad.cantHorasFamilia()
	}
	
}



	
	