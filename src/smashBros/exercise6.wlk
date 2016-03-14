package SmashBros {
	class Character {
		var damage = 0
		method damage() = damage
		method damage(_damage) { damage = _damage }
		method receiveAttackOf(power) { damage += power }
		method isKO() = damage > character.maxDamage()
		method isStanding() = ! self.isKO()
		method offensivePower() method attack(target) {
			target.receiveAttackOf(self.offensivePower())
		}
	}

	object character {
		var maxDamage = 200

		method maxDamage() = maxDamage
		method maxDamage(_maxDamage) { maxDamage = _maxDamage }
	}

	object captainFalcon inherits Character {
		override method offensivePower() = 9999
	}

	object jigglypuff inherits Character {
		var offensivePower = 250

		override method offensivePower() = offensivePower
		override method attack(target) {
			target.receiveAttackOf(self.offensivePower()) 
			offensivePower = offensivePower / 2
		}
	}

	object link inherits Character {
		var basePower = 100
		var weapon
		override method offensivePower() {
			return basePower + weapon.powerFor(self)
		}
		override method attack(target) {
			super(target) weapon.hasAttacked()
		}
		method basePower() = basePower
		method weapon(_weapon) { weapon = _weapon }
	}

	object masterSword {
		method powerFor(_) = 100
		method hasAttacked() { }
	}

	object boomerang {
		method powerFor(carrier) = carrier.basePower()
		method hasAttacked() { }
	}

	object bowAndArrow {
		var numberOfArrows = 10
		method powerFor(_) = numberOfArrows * 5
		method hasAttacked() { numberOfArrows -= 1 }
	}

	object zelda inherits Character {
		var weapons = #{ masterSword, boomerang, bowAndArrow } var basePower = 50

		method basePower() = basePower
		override method offensivePower() = self.basePower() + self.weaponsPower()
		method weaponsPower() = weapons.sum({ aWeapon => aWeapon.powerFor(self) })
		override method attack(target) {
			if (self.offensivePower() < target.offensivePower()) {
				super(target) self.loseMostPowerfulWeapon()
			} else super(target) weapons.forEach({ aWeapon => aWeapon.hasAttacked() })
		}
		method loseMostPowerfulWeapon() {
			var weaponToLose = weapons.max({ aWeapon => aWeapon.powerFor(self) })
			weapons.remove(weaponToLose)
		}
	}

	class Sword {
		var power

		constructor(aPower) { power = aPower }
		method powerFor(_) = power
	}

	class Equipo {
		var members

		constructor(_members) { members = _members }
		method members() = members
		method numberOfStandingMembers() = self.standingMembers().size()
		method standingMembers() = members.filter({ aCharacter =>
		aCharacter.isStanding() })
		method attack(target) {
			var attackers = self.standingMembers()
			if (attackers.isEmpty()) throw
			new CannotAttackException("No attackers available") attackers.forEach({
			aMember => aMember.attack(target) })
		}
		method receiveAttackOf(aPower) {
			self.weakestMember().receiveAttackOf(aPower)
		}
		method weakestMember() = self.standingMembers().min({ aMember =>
		aMember.offensivePower() })

		method offensivePower() = self.weakestMember().offensivePower()
	}

	class CannotAttackException inherits Exception {

		constructor(_text) {
			self.text(_text)
		}
	}
}
