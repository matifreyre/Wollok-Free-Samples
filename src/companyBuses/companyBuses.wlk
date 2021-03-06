
class StillNotDedicedException inherits wollok.lang.Exception {
}

class NoCapacityException inherits wollok.lang.Exception {
}

object bus {
	var volume = 100
	const numberOfSeats = 30
	const standingCapacity = 20
	const peopleOnBoard = []
	
	method volume() = volume
	method volume(_volume) { volume = _volume }

	/** True when the bus has a greater capacity than the given parameter */
	method hasAGreaterCapacityThan(aCapacity) {
		return self.volume() > aCapacity
	}
	method hasAvailableSeats() = numberOfSeats > self.numberOfPeopleOnBoard()
	method numberOfPeopleOnBoard() = peopleOnBoard.size()
	method hopOn(aPerson) {
		if(!self.hasAvailability()) throw new NoCapacityException()
		peopleOnBoard.add(aPerson)
	}
	method totalCapacity() = numberOfSeats + standingCapacity
	method hasAvailability() = self.totalCapacity() > self.numberOfPeopleOnBoard() 
}

class Person {
	var boss

	method boss(_boss) { boss = _boss }
	method boss() { return boss }
	method wantsToHopOnTo(aBus) {
		return false
	}
}

class Undecided inherits Person {
	override method wantsToHopOnTo(aBus) {
		throw new StillNotDedicedException()
	}
}

class Hurried inherits Person {
	override method wantsToHopOnTo(aBus) {
		return true
	}
}

class Claustrophobic inherits Person {
	override method wantsToHopOnTo(aBus) {
		return aBus.hasAGreaterCapacityThan(120)
	}
}

class Obsequious inherits Person {
	override method wantsToHopOnTo(aBus) {
		return self.boss().wantsToHopOnTo(aBus)
	}
}

class Lazy inherits Person {
	override method wantsToHopOnTo(aBus) {
		return aBus.hasAvailableSeats()
	}
}