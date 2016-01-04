
class Vehicle {
	method numberOfPassengers()
	method maxSpeed()
	method expenseFor100Km()
	method efficiency(){
		return this.numberOfPassengers() * this.maxSpeed() / 
			this.expenseFor100Km()
	}
}
 
class Bike inherits Vehicle {
	var wheelSize

	constructor(_wheelSize) {
		wheelSize = _wheelSize
	}
	override method maxSpeed() { return wheelSize * 1.2 }
	override method expenseFor100Km() { return 1 }
	override method numberOfPassengers() { return 1 }
}

class Moto inherits Vehicle {
	var cylindersVolume

	constructor(_cylindersVolume) {
		cylindersVolume = _cylindersVolume
	}
	override method maxSpeed() { return cylindersVolume / 5 }
	override method expenseFor100Km() { return 5 + cylindersVolume / 200 }
	override method numberOfPassengers() { return if (cylindersVolume < 150) 1 else 2 }
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
 
object company {
	var vehicles = #{}
	
	method vehiclesFasterThan(aSpeed) {
		return vehicles.filter({vehicle => vehicle.maxSpeed() > aSpeed})
	}
	method vehiclesThatConsumeLessThan(anExpense) {
		return vehicles.filter({vehicle => vehicle.expenseFor100Km() < anExpense})
	}
	method mostEfficientVehicle() {
		return vehicles.max({vehicle => vehicle.efficiency()})
	}
	method numberOfPassengersQuePuedenTransportarseAMasDe(aSpeed){
		return this.vehiclesFasterThan(aSpeed).
			map({vehicle => vehicle.numberOfPassengers()})
	}
}