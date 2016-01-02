
class Vehicle {
	method numberOfPassengers()
	method maxSpeed()
	method expenseFor100Km()
	method efficiency(){
		return this.numberOfPassengers() * this.maxSpeed() / 
			this.expenseFor100Km()
	}
}
 
class Bicicleta inherits Vehicle {
	var rodado

	constructor(_rodado) {
		rodado = _rodado
	}
	override method maxSpeed() { return rodado * 1.2 }
	override method expenseFor100Km() { return 1 }
	override method numberOfPassengers() { return 1 }
}

class Moto inherits Vehicle {
	var cilindrada

	constructor(_cilindrada) {
		cilindrada = _cilindrada
	}
	override method maxSpeed() { return cilindrada / 5 }
	override method expenseFor100Km() { return 5 + cilindrada / 200 }
	override method numberOfPassengers() { return if (cilindrada < 150) 1 else 2 }
}

class Car inherits Vehicle {
	var maxSpeed
	var numberOfPassengers

	constructor(_maxSpeed, _numberOfPassengers) {
		maxSpeed = _maxSpeed 
		numberOfPassengers = _numberOfPassengers
	}
	override method maxSpeed() { return maxSpeed }
	override method expenseFor100Km() { return 20 + numberOfPassengers * 10 }
	override method numberOfPassengers() { return numberOfPassengers }
}
 
object empresa {
	var vehicles = #{}
	
	method vehiclesConVelocidadMayorA(aSpeed) {
		return vehicles.filter({vehicle => vehicle.maxSpeed() > aSpeed})
	}
	method vehiclesQueConsumenMenosQue(anExpense) {
		return vehicles.filter({vehicle => vehicle.expenseFor100Km() < anExpense})
	}
	method vehicleMasEficiente() {
		return vehicles.max({vehicle => vehicle.efficiency()})
	}
	method numberOfPassengersQuePuedenTransportarseAMasDe(aSpeed){
		return this.vehiclesConVelocidadMayorA(aSpeed).
			map({vehicle => vehicle.numberOfPassengers()})
	}
}