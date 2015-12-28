
class StillNotDedicedException inherits wollok.lang.Exception {
}

object bus {
	var volume = 100

	method volume(_volume) { volume = _volume }
	method volume() { return volume }

	/** True when the bus has a greater capacity than the given parameter */
	method hasAGreaterCapacityThan(aCapacity) {
		return this.volume() > aCapacity
	}
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
		return this.boss().wantsToHopOnTo(aBus)
	}
}