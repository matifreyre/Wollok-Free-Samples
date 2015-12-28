
class Vehiculo {
	method cantidadDePasajeros()
	method velocidadMaxima()
	method gastoCada100Km()
	method eficiencia(){
		return this.cantidadDePasajeros() * this.velocidadMaxima() / 
			this.gastoCada100Km()
	}
}
 
class Bicicleta inherits Vehiculo {
	var rodado

	new(_rodado) {
		rodado = _rodado
	}
	override method velocidadMaxima() { return rodado * 1.2 }
	override method gastoCada100Km() { return 1 }
	override method cantidadDePasajeros() { return 1 }
}

class Moto inherits Vehiculo {
	var cilindrada

	new(_cilindrada) {
		cilindrada = _cilindrada
	}
	override method velocidadMaxima() { return cilindrada / 5 }
	override method gastoCada100Km() { return 5 + cilindrada / 200 }
	override method cantidadDePasajeros() { return if (cilindrada < 150) 1 else 2 }
}

class Auto inherits Vehiculo {
	var velocidadMaxima
	var cantidadDePasajeros

	new(_velocidadMaxima, _cantidadDePasajeros) {
		velocidadMaxima = _velocidadMaxima 
		cantidadDePasajeros = _cantidadDePasajeros
	}

	override method velocidadMaxima() { return velocidadMaxima }
	override method gastoCada100Km() { return 20 + cantidadDePasajeros * 10 }
	override method cantidadDePasajeros() { return cantidadDePasajeros }
}

object empresa {
	var vehiculos = #{}
	method vehiculosConVelocidadMayorA(unaVelocidad) {
		return vehiculos.filter([vehiculo | vehiculo.velocidadMaxima() > unaVelocidad])
	}
	method vehiculosQueConsumenMenosQue(unConsumo) {
		return vehiculos.filter([vehiculo | vehiculo.gastoCada100Km() < unConsumo])
	}
	method vehiculoMasEficiente() {
		return vehiculos.max([vehiculo | vehiculo.eficiencia()])
	}
	method cantidadDePasajerosQuePuedenTransportarseAMasDe(unaVelocidad){
		return this.vehiculosConVelocidadMayorA(unaVelocidad).
			map([vehiculo | vehiculo.cantidadDePasajeros()])
	}
}