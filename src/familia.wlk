class Familia {

	const integrantesFamiliares=[]
	
	method agregarPersona(unaPersona){
		integrantesFamiliares.add(unaPersona)	
	}
	
	method cantIntegrantes()=return integrantesFamiliares.size()
	
	//---------Punto3--------------------------------
	method estasHabilitada(unaPropiedad){
		
		return unaPropiedad.sosHabitable() && self.superasHorasTrabajadas(unaPropiedad) && unaPropiedad.personasSoportadas()>self.cantIntegrantes()+1		
	}
	
	method horasTrabajadas() {	
		return integrantesFamiliares.sum({unaPersona => unaPersona.cantHorasTrabajadas()})
	}
	
	method superasHorasTrabajadas(unaPropiedad){
		return self.horasTrabajadas() > unaPropiedad.cantHorasNecesitaRealizarUnaFamilia()
	}
	
}



	
	