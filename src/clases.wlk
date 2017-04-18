object estado{
	const casasIncautadas=[]
	const familiasParticipantes=[]
	
	method cantCasasIncautadas()=casasIncautadas.size()
	
	//--------------------Punto 1-----------------------------------
	method incautarPropiedad(propiedad){casasIncautadas.add(propiedad)}
	
}

//---------------------------------------------------------------------------------
class Casa_Incautada {

	var horasTrabajoRestantes
	var horasDeTrabajoPorFamilia
	const habitantes=[]
	
	constructor(trabajoRestantes, trabajoPorFamilia){
		horasTrabajoRestantes=trabajoRestantes
		horasDeTrabajoPorFamilia=trabajoPorFamilia
	}
	
	method horasTrabajoRestantes()=horasTrabajoRestantes
	
	method disminuirHorasNecesarias(horas) {horasTrabajoRestantes-=horas}

	//falta definir cumplioHorasNecesarias()
	/*dudas porque en el enunciado dice "Una familia esta habilitada si y no se que es familia" */
	method sosHabitablePara(familia){
		return self.sosHabitable() && familia.cumplioHorasNecesarias() && self.tamanioAcorde(familia)
	}
	
	method sosHabitable(){
		return self.sosDigna() && !self.tenesHabitantes()
	}
	
	method tamanioAcorde(familia)
	
	method sosDigna() = horasTrabajoRestantes==0
	method tenesHabitantes() = habitantes.size()>0
	
}

//---------------------------------------------------------------------------------
class Casa inherits Casa_Incautada{
	var ambientes
	
	constructor(_ambientes,trabajoRestantes, trabajoPorFamilia)=super(trabajoRestantes, trabajoPorFamilia){
		ambientes=_ambientes
	}
	
	override method tamanioAcorde(familia){
		return ambientes+1>familia.size()
	}
	
}

//---------------------------------------------------------------------------------
class Departamento inherits Casa_Incautada{
	var superficie
	
	constructor(trabajoRestantes, trabajoPorFamilia, _superficie)=super(trabajoRestantes, trabajoPorFamilia){	
		superficie=_superficie
	}
	
	override method tamanioAcorde(familia){
		return superficie>=15*familia.size()
	}
	
}

//---------------------------------------------------------------------------------
class Integrante {
	var nombre
	var edad
	var cantHorasTrabajadas
	var representante
	
	constructor(_nombre, _edad, _cantHorasTrabajadas, _representante){
		nombre=_nombre
		edad=_edad
		cantHorasTrabajadas=_cantHorasTrabajadas
		representante=_representante
	}
	
	method cantHorasTrabajadas()=cantHorasTrabajadas
	method podesTrabajar(){return edad>=18 && edad<=65}
	
	//--------------------Punto 2-----------------------------------
	method trabajaEn(horas, propiedad){
		
		if(self.podesTrabajar()){
			cantHorasTrabajadas+=horas
			propiedad.disminuirHorasNecesarias(horas)	
		} else{
			throw new UserException("No pude trabajar")
		}
		
	}
	

}

//---------------------------------------------------------------------------------
class UserException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}

//---------------------------------------------------------------------------------
object fixture {

	method crearCasa(ambientes,cantHorasTrabajoRestante, cantHorasPorFamilia){		
		return new Casa(ambientes,cantHorasTrabajoRestante, cantHorasPorFamilia)
	}
	
	method crearDepto(cantHorasTrabajoRestante, cantHorasPorFamilia, soporte){		
		return new Departamento(cantHorasTrabajoRestante, cantHorasPorFamilia, soporte)
	}
	
	method crearIntegrante(nombre, edad, cantHorasTrabajadas, representante){		
		return new Integrante(nombre, edad, cantHorasTrabajadas, representante)
	}

}

