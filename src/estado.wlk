object estado{
	
	const casasIncautadas=[]
	
	method cantCasasIncautadas()=casasIncautadas.size()
	
	//--------------------Punto 1-----------------------------------
	method incautarPropiedad(propiedad){
		casasIncautadas.add(propiedad)
	}
	
	method eliminarCasa(propiedad){
		casasIncautadas.remove(propiedad)
	}
	
}





