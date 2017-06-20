import plan_vivienda.estado.*
import plan_vivienda.propiedad.*
import plan_vivienda.persona.*
import plan_vivienda.familia.*
import plan_vivienda.tipoDeHabilidades.*

object fixture {
	
	//Creacion de Casas
	//new Casa(estadoPropiedad,cantHsPendienteParaSerHabitable,cantHsNecesitaRealizarUnaFamilia,familiaOcupante,ambientes)
	var casaLomas=new Casa("Libre",50,25,"",4)
	var casaMoreno=new Casa("Ocupada",70,37,"familiaGago",3)
	
	//Creacion de Departamento
	//new Departamento(estadoPropiedad,cantHsPendienteParaSerHabitable,cantHsNecesitaRealizarUnaFamilia,familiaOcupante,superficie)
	var deptoAlmagro=new Departamento("Libre",54,54,"",60)
	var deptoPalermo=new Departamento("Ocupada",74,74,"familiaLema",30)
	
	//Creacion de Personas
	//new Persona(nombre,edad,habilidad)
	var fernando=new Persona("Fernando", 21,electricista)
	var gustavo=new Persona("Gustavo", 21,electricista)
	var carlos=new Persona("Carlos",78,desordenado)
	var german=new Persona("German",13,electricista)
	var leandro=new Persona("Leandro",32,electricista)
	var maria=new Persona("Maria",30,decoradora)
	var juan=new Persona("Juan",32,electricista)
	var marcos=new Persona("Marcos",30,decoradora)
	
	//Creacion de Familia
	var familiaPerez = new Familia()
	var familiaRodriguez = new Familia()
	var familiaLopez = new Familia()
	
	method casaLomas()=casaLomas
	method deptoAlmagro()=deptoAlmagro
	method deptoPalermo()=deptoPalermo
	
	method fernando()=fernando
	method gustavo()=gustavo
	method carlos()=carlos
	method german()=german
	
	method incautarPropiedades(){
		estado.incautarPropiedad(casaLomas)
		estado.incautarPropiedad(casaMoreno)
		estado.incautarPropiedad(deptoAlmagro)
		estado.incautarPropiedad(deptoPalermo)
	}
	
	method agregarFamiliasAlPlan(){
		estado.agregarFamiliaAlPlan(familiaPerez)
		estado.agregarFamiliaAlPlan(familiaRodriguez)
		estado.agregarFamiliaAlPlan(familiaLopez)
	}
	
	method perez()=familiaPerez
	method rodriguez()=familiaRodriguez
	method lopez()=familiaLopez
	
	method familiaPerez(){
		familiaPerez.integranteFamiliar(leandro)
		familiaPerez.integranteFamiliar(maria)
		
		leandro.trabajar(20,deptoPalermo)
		maria.trabajar(25,deptoPalermo)	
	}

	method familiaRodriguez(){
		familiaRodriguez.integranteFamiliar(juan)
		familiaRodriguez.integranteFamiliar(marcos)
		
		juan.trabajar(20,deptoPalermo)
		marcos.trabajar(25,deptoPalermo)	
	}
	
	method familiaLopez(){
		familiaLopez.integranteFamiliar(fernando)
		familiaLopez.integranteFamiliar(gustavo)
		
		fernando.trabajar(20,deptoAlmagro)
		gustavo.trabajar(25,deptoAlmagro)	
	}
	
}