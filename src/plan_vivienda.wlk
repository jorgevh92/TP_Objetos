class UserException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}

package estado{
	
	object estado{
		
		const planVivienda=[] //Concepto: Coleccion
		const propiedadesIncautadas=[] //Concepto: Coleccion
		
		method incautarPropiedad(unaPropiedad){
			propiedadesIncautadas.add(unaPropiedad) //Concepto: Coleccion
			unaPropiedad.incautada()
		}
		
		method eliminarPropiedad(unaPropiedad){
			propiedadesIncautadas.remove(unaPropiedad) //Concepto: Coleccion
		}
		
		method agregarFamiliaAlPlan(unaFamilia){
			planVivienda.add(unaFamilia) //Concepto: Coleccion
		}
		
		method eliminarFamiliaDelPlan(unaFamilia){
			planVivienda.remove(unaFamilia) //Concepto: Coleccion
		}
		
		method cantPropiedadesIncautadas()=propiedadesIncautadas.size() //Concepto: Coleccion
		
		method familiasHabilitadasParaAcceder(unaPropiedad)=planVivienda.filter({unaFamilia=>unaFamilia.estasHabilitadaParaAcceder(unaPropiedad)}) //Concepto: Coleccion
		
		method asignar(unaFamilia,unaPropiedad){
			if(unaFamilia.estasHabilitadaParaAcceder(unaPropiedad)){
				unaPropiedad.asignarPropiedad(unaFamilia)
				self.eliminarFamiliaDelPlan(unaFamilia)
				self.eliminarPropiedad(unaPropiedad)
			}else {
				throw new UserException("No se puede asignar la propiedad") //Concepto: Manejo de Excepciones
			}
		}

		method propiedadesHabitables()=propiedadesIncautadas.filter({unaPropiedad => unaPropiedad.sosHabitable()})
		
		method asignarPropiedades(){
			
			var propiedadesHabitables = self.propiedadesHabitables()

 			if (propiedadesHabitables==[]){
				throw new UserException("No hay propiedades habitables para asignar") //Concepto: Manejo de Excepciones
			}else{
				propiedadesHabitables.forEach({unaPropiedad => 
					var unaFamilia=self.familiasHabilitadasParaAcceder(unaPropiedad)
					if (unaFamilia!=[]){
						self.asignar(unaFamilia.first(),unaPropiedad)
					}
				})
			}
			
		}
		
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
		
		method tamanioAcorde(unaFamilia)=self.personasSoportadas()>=unaFamilia.cantIntegrantes()&&self.personasSoportadas()<=unaFamilia.cantIntegrantes()+1
		
		method personasSoportadas()
		
	}
	
	
	class Casa inherits Propiedad{ //Clase Polimorfica
		
		var ambientes
		
		constructor(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante,_ambientes)=super(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante){
			ambientes=_ambientes
		}
		
		override method personasSoportadas()=ambientes
		
	}
	
	class Departamento inherits Propiedad{ //Clase Polimorfica

		var superficie
		
		constructor(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante,_superficie)=super(_estadoPropiedad,_cantHsPendienteParaSerHabitada,_cantHsNecesitaRealizarUnaFamilia,_familiaOcupante){
			superficie=_superficie
		}
		
		override method personasSoportadas()=superficie/15
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
				throw new UserException("Persona menor de 18 años, no puede trabajar") //Concepto: Manejo de Excepciones
			}
			
			if (edad>65){
				throw new UserException("Persona mayor de 65 años, no puede trabajar") //Concepto: Manejo de Excepciones
			}
			
		}
		
		method trabajar(horas,unaPropiedad){
			try{
				self.cumplisRangoDeEdad()
				self.aumentarHoras(habilidad.contabilizarHora(horas))
				unaPropiedad.descontarHoras(habilidad.contabilizarHora(horas))
			} catch e: UserException{
				self.mostrarMensajeDeAdvertencia(e.getMessage()) //Concepto: Manejo de Excepciones
			}
		}
	
		method mostrarMensajeDeAdvertencia(_mensaje){
			throw new UserException(_mensaje)
		}
		
	}
}

package familia{
	
	class Familia{
		
		const integrantesFamiliares=[] //Concepto: Coleccion
		var representanteFamiliar
		
		method integranteFamiliar(integrante){
			integrantesFamiliares.add(integrante) //Concepto: Coleccion
		}
		
		method representanteFamiliar(_representanteFamiliar){
			representanteFamiliar=_representanteFamiliar
		}
		
		method estasHabilitadaParaAcceder(unaPropiedad){
			return unaPropiedad.sosHabitable()&&self.cumplisHsNecesariasParaAcceder(unaPropiedad)&&unaPropiedad.tamanioAcorde(self)
		}
		
		method cumplisHsNecesariasParaAcceder(unaPropiedad)=(unaPropiedad.cantHsNecesitaRealizarUnaFamilia()==self.hsTrabajadasEnFamilia())
		
		method hsTrabajadasEnFamilia()=integrantesFamiliares.sum({persona => persona.cantHsTrabajadas()}) //Concepto: Coleccion
		
		method cantIntegrantes()=integrantesFamiliares.size() //Concepto: Coleccion
		
	}
	
}

package tipoDeHabilidades{
	
	class TipoDeHabilidades{
		method contabilizarHora(horas)
	}
	
	//-----------------Defino los tipos de habilidades--------------------
	object electricista inherits TipoDeHabilidades{ //Objeto Polimorfico
		override method contabilizarHora(horas){		
			return horas*1.20
		}
	}

	object decoradora inherits TipoDeHabilidades{ //Objeto Polimorfico
		override method contabilizarHora(horas){		
			return horas*2
		}
	}

	object desordenado inherits TipoDeHabilidades{ //Objeto Polimorfico
		override method contabilizarHora(horas){		
			return horas*0.75
		}
	}

	object normal inherits TipoDeHabilidades{ //Objeto Polimorfico
		override method contabilizarHora(horas)=horas
	}

}