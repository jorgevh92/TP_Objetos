import estado.*
import excepcion.*

class Propiedad {

	var cantHorasRestantes
	var cantHorasNecesitaRealizarUnaFamilia
	var familiaAsignada=""
	const familiasParticipantes=[]
	
	constructor(_cantHorasRestantes, _cantHorasNecesitaRealizarUnaFamilia){
		cantHorasRestantes=_cantHorasRestantes
		cantHorasNecesitaRealizarUnaFamilia=_cantHorasNecesitaRealizarUnaFamilia	
	}
	
	method cantHorasNecesitaRealizarUnaFamilia()=cantHorasNecesitaRealizarUnaFamilia
	
	method agregarFamilia(unaFamilia){
		familiasParticipantes.add(unaFamilia)
	} 
	
	method sosDigna()=cantHorasRestantes==0
	
	method sosHabitable(){
		return self.sosDigna() && !self.estasOcupada()
	}
	
	method estasOcupada() {		
		return familiaAsignada!=""
	}
	
	method descontarHoras(horas){
		cantHorasRestantes-=(cantHorasRestantes.min(horas))
	}
	
	//-----------punto4-----------------------------------------
	method familiasHabilitadas(){
		return familiasParticipantes.filter({unaFamilia => unaFamilia.estasHabilitada(self)})
	}
	
	//-----------punto5---------------------------------------
	method podesAsignarA(unaFamilia){
		
		if(unaFamilia.estasHabilitada(self)){
			
			familiaAsignada=unaFamilia
			self.eliminarFamilia(unaFamilia)
			estado.eliminarPropiedad(self)
			
		}else {
			
			throw new UserException("No se puede asignar la propiedad")
		}
		
	}
	
	method eliminarFamilia(unaFamilia){
		familiasParticipantes.remove(unaFamilia)
	}	

}














