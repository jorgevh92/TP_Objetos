class UserException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}

package estado{
	
	object estado{
		
		const planVivienda=[]
		const propiedadesIncautadas=[]
		
		method incautarPropiedad(unaPropiedad){
			propiedadesIncautadas.add(unaPropiedad)
			unaPropiedad.incautada()
		}
		
		method eliminarPropiedad(unaPropiedad){
			propiedadesIncautadas.remove(unaPropiedad)
		}
		
		method agregarFamiliaAlPlan(unaFamilia){
			planVivienda.add(unaFamilia)
		}
		
		method eliminarFamiliaDelPlan(unaFamilia){
			planVivienda.remove(unaFamilia)
		}
		
		method cantPropiedadesIncautadas()=propiedadesIncautadas.size()
		
		method familiasHabilitadasParaAcceder(unaPropiedad)=planVivienda.filter({unaFamilia=>unaFamilia.estasHabilitadaParaAcceder(unaPropiedad)})
		
		method asignar(unaFamilia,unaPropiedad){
			if(unaFamilia.estasHabilitadaParaAcceder(unaPropiedad)){
				unaPropiedad.asignarPropiedad(unaFamilia)
				self.eliminarFamiliaDelPlan(unaFamilia)
				self.eliminarPropiedad(unaPropiedad)
			}else {
				throw new UserException("No se puede asignar la propiedad")
			}
		}
		
		/*
		 * 
		 * method asignarPropiedades(){
		
		propiedades.addAll(propiedadesIncautadas)
		propiedades.forEach({unaPropiedad => 
			var familiasHabilitadas=unaPropiedad.familiasHabilitadas()
			if (familiasHabilitadas!=[]){
				unaPropiedad.podesAsignarA(familiasHabilitadas.first())
			}
		})
		}
		 * 
		 */
		
	}
	
}

package propiedad{
	
	class Propiedad{
		
		var estadoPropiedad
		var cantHsPendienteParaSerHabitable
		var cantHsNecesitaRealizarUnaFamilia
		var familiaOcupante
		
		constructor(_estadoPropiedad,_cantHsPendienteParaSerHabitable,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante){
			estadoPropiedad=_estadoPropiedad
			cantHsPendienteParaSerHabitable=_cantHsPendienteParaSerHabitable
			cantHsNecesitaRealizarUnaFamilia=_cantHsNecesitaRealizarUnaFamilia
			familiaOcupante=_familiaOcupante			
		}
		
		method estadoPropiedad()=estadoPropiedad
		method cantHsPendienteParaSerHabitada()=cantHsPendienteParaSerHabitable
		method cantHsNecesitaRealizarUnaFamilia()=cantHsNecesitaRealizarUnaFamilia
		method familiaOcupante()=familiaOcupante
		
		method incautada(){
			estadoPropiedad="Incautada"
			familiaOcupante=""
		}
		
		method asignarPropiedad(unaFamilia){
			estadoPropiedad="Asignada"
			familiaOcupante=unaFamilia
		}
		
		method descontarHoras(horas){
			cantHsPendienteParaSerHabitable-=(cantHsPendienteParaSerHabitable.min(horas))
		}
		
		method sosHabitable()=self.sosDigna() && !self.estasOcupada()
		
		method sosDigna()=(cantHsPendienteParaSerHabitable==0)
		method estasOcupada()=(familiaOcupante!="")
		
		method tamanioAcorde(unaFamilia)=self.personaSoportadas()>=unaFamilia.cantIntegrantes()&&self.personaSoportadas()<=unaFamilia.cantIntegrantes()+1
		
		method personaSoportadas()
		
	}
	
	
	class Casa inherits Propiedad{
		
		var ambientes
		
		constructor(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante,_ambientes)=super(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante){
			ambientes=_ambientes
		}
		
		override method personaSoportadas()=ambientes
		
	}
	
	class Departamento inherits Propiedad{

		var superficie
		
		constructor(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante,_superficie)=super(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante){
			superficie=_superficie
		}
		
		override method personaSoportadas()=superficie/15
	}
	
}

package persona{

	class Persona{
		var nombre
		var edad
		var cantHsTrabajadas=0
		var habilidad
		
		constructor(_nombre,_edad,_habilidad){
			nombre=_nombre
			edad=_edad
			habilidad=_habilidad
		}
		
		method nombre()=nombre
		method edad()=edad
		method cantHsTrabajadas()=cantHsTrabajadas
		
		method aumentarHoras(horas){
			cantHsTrabajadas+=horas
		}
		
		method cumplisRangoDeEdad(){
			
			if (edad<18){
				throw new UserException("Persona menor de 18 años, no puede trabajar")
			}
			
			if (edad>65){
				throw new UserException("Persona mayor de 65 años, no puede trabajar")
			}
			
		}
		
		method trabajar(horas,unaPropiedad){
			try{
				self.cumplisRangoDeEdad()
				self.aumentarHoras(habilidad.contabilizarHora(horas))
				unaPropiedad.descontarHoras(habilidad.contabilizarHora(horas))
			} catch e: UserException{
				self.mostrarMensajeDeAdvertencia(e.getMessage())
			}
		}
	
		method mostrarMensajeDeAdvertencia(_mensaje){
			throw new UserException(_mensaje)
		}
		
	}
}

package familia{
	
	class Familia{
		
		const integrantesFamiliares=[]
		var representanteFamiliar
		
		method integranteFamiliar(integrante){
			integrantesFamiliares.add(integrante)
		}
		
		method representanteFamiliar(_representanteFamiliar){
			representanteFamiliar=_representanteFamiliar
		}
		
		method estasHabilitadaParaAcceder(unaPropiedad){
			return unaPropiedad.sosHabitable()&&self.cumplisHsNecesariasParaAcceder(unaPropiedad)&&unaPropiedad.tamanioAcorde(self)
		}
		
		method cumplisHsNecesariasParaAcceder(unaPropiedad)=(unaPropiedad.cantHsNecesitaRealizarUnaFamilia()==self.hsTrabajadasEnFamilia())
		
		method hsTrabajadasEnFamilia()=integrantesFamiliares.sum({persona => persona.cantHsTrabajadas()})
		
		method cantIntegrantes()=integrantesFamiliares.size()
	}
	
}

package tipoDeHabilidades{
	
	class TipoDeHabilidades{
		method contabilizarHora(horas)
	}
	
	//-----------------Defino los tipos de habilidades--------------------
	object electricista inherits TipoDeHabilidades{
		override method contabilizarHora(horas){		
			return horas*1.20
		}
	}

	object decoradora inherits TipoDeHabilidades{
		override method contabilizarHora(horas){		
			return horas*2
		}
	}

	object desordenado inherits TipoDeHabilidades{
		override method contabilizarHora(horas){		
			return horas*0.75
		}
	}

	object normal inherits TipoDeHabilidades{
		override method contabilizarHora(horas)=horas
	}

}