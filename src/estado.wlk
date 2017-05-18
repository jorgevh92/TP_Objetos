object estado{
	
	const propiedadesIncautadas=[]
	
	method cantPropiedadesIncautadas()=propiedadesIncautadas.size()
	
	//--------------------Punto 1-----------------------------------
	method incautarPropiedad(propiedad){
		propiedadesIncautadas.add(propiedad)
	}
	
	method eliminarPropiedad(propiedad){
		propiedadesIncautadas.remove(propiedad)
	}
	
	//--------------------Punto 6-----------------------------------
	method asignarPropiedades(){
		
		propiedadesIncautadas.forEach({unaPropiedad => 
			var familiasHabilitadas=unaPropiedad.familiasHabilitadas()
			if (familiasHabilitadas!=[]){
				unaPropiedad.podesAsignarA(familiasHabilitadas.first())
			}
		})
		
	}
	
}





