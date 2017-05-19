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

	override method contabilizarHora(horas){		
		return horas
	}	
}