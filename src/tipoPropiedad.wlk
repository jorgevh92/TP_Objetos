import propiedad.*

class Casa inherits Propiedad{
	
	var ambientes
	
	constructor(_cantHorasRestantes, _cantHorasFamilia,_ambientes)= super(_cantHorasRestantes, _cantHorasFamilia){
		ambientes=_ambientes
	}
	
	method personasSoportadas(){
		return ambientes
	}
	
}

class Departamento inherits Propiedad{
	
	var superficie
	
	constructor(_cantHorasRestantes, _cantHorasFamilia,_superficie)= super(_cantHorasRestantes, _cantHorasFamilia){
		superficie=_superficie
	}
	
	method personasSoportadas(){
		return superficie/15
	}
	
	
}