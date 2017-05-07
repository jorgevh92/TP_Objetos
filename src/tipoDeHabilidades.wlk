
class Interfaz{
	
	method contabilizarHora(horas)
}

//-----------------Defino los tipos de habilidades--------------------

object electricista inherits Interfaz{

	override method contabilizarHora(horas){		
		return horas*1.20
	}
}

object decoradora inherits Interfaz{

	override method contabilizarHora(horas){		
		return horas*2
	}	
}

object desordenado inherits Interfaz{

	override method contabilizarHora(horas){		
		return horas*0.75
	}	
}

object normal inherits Interfaz{

	override method contabilizarHora(horas){		
		return horas
	}	
}