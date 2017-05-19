object estado{
	
	const propiedadesIncautadas=[]
	const propiedades=[]
	
	method cantPropiedadesIncautadas()=propiedadesIncautadas.size()

	//--------------------Punto 1-----------------------------------
	method incautarPropiedad(unaPropiedad){
		
		propiedadesIncautadas.add(unaPropiedad)

	}
	
	//--------------------Punto 5-----------------------------------
	method eliminarPropiedad(unaPropiedad){
		propiedadesIncautadas.remove(unaPropiedad)
	}
	
	//--------------------Punto 6-----------------------------------
	method asignarPropiedades(){
		
		propiedades.addAll(propiedadesIncautadas)
		propiedades.forEach({unaPropiedad => 
			var familiasHabilitadas=unaPropiedad.familiasHabilitadas()
			if (familiasHabilitadas!=[]){
				unaPropiedad.podesAsignarA(familiasHabilitadas.first())
			}
		})
		
	}
	
}