import estado.*
import excepcion.*

class Propiedad {

	var cantHorasRestantes
	const cantHorasFamilia
//JFV - INI
//  var familia=[]
//JFV-FIN
	var familia=""
	const familiasParticipantes=[]
	
	constructor(_cantHorasRestantes, _cantHorasFamilia){
		cantHorasRestantes=_cantHorasRestantes
		cantHorasFamilia=_cantHorasFamilia	
	}
	
	method cantHorasFamilia()=cantHorasFamilia
	
	method agregarFamilia(unaFamilia){
		familiasParticipantes.add(unaFamilia)
	} 
	
	method sosDigna()=cantHorasRestantes==0
	
	method sosHabitable(){
		return self.sosDigna() && !self.estasOcupada()
	}
	
	method estasOcupada() {
//JFV - INI
//      return familia.size()>0
//JFV - FIN		
		return familia!=""
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
			familia=unaFamilia
			self.eliminarFamilia(unaFamilia)
			estado.eliminarCasa(self)
			
		}else {
			
			throw new UserException("No se puede asignar la propiedad")
		}
		
	}
	
	method eliminarFamilia(unaFamilia){
		familiasParticipantes.remove(unaFamilia)
	}
	

}














