package SmashBros {
	class Character {
		var damage = 0
		method damage(){ return damage }
		method damage(_damage){ damage = _damage}
		method receiveAttackOf(power) { damage += power }
		method isKO(){ return damage > character.maxDamage()}
		method isStanding(){ return !this.isKO() }
		method offensivePower()
		method attack(target) {
			target.receiveAttackOf(this.offensivePower())
		}
	} 
	
	object character {
		var maxDamage = 200
		method maxDamage() {return maxDamage}
		method maxDamage(_maxDamage) {maxDamage = _maxDamage}
	}
	
	object captainFalcon inherits Character {
		override method offensivePower() {
			return 9999
		}
	} 
	
	object jigglypuff inherits Character {
		var offensivePower = 250
		override method offensivePower() {
			return offensivePower
		}
		override method attack(target) {
			target.receiveAttackOf(this.offensivePower()) offensivePower =
			offensivePower / 2
		}
	}
	
	object link inherits Character {
		var basePower = 100
		var weapon
		override method offensivePower() {
			return basePower + weapon.powerFor(this)
		}
		override method attack(target) {
			super(target) 
			weapon.hasAttacked()
		}
		method basePower() { return basePower }
		method weapon(_weapon) { weapon = _weapon }
	}
	
	object masterSword {
		method powerFor(_) { return 100 }
		method hasAttacked() { }
	}

	object boomerang {
		method powerFor(carrier) { return carrier.basePower() }
		method hasAttacked() { }
	}

	object bowAndArrow {
		var numberOfArrows = 10
		method powerFor(_) { return numberOfArrows * 5 }
		method hasAttacked() { numberOfArrows -= 1 }
	}
	
	object zelda inherits Character {
		var weapons = #{ masterSword , boomerang , bowAndArrow } 
		var basePower = 50

		method basePower() { return basePower }

		override method offensivePower() { 
			return this.basePower() + this.weaponsPower()
		}
		
		method weaponsPower(){
			return weapons.sum({ aWeapon => aWeapon.powerFor(this) })
		}

		override method attack(target) {
			if (this.offensivePower() < target.offensivePower()){
				super(target)
				this.loseMostPowerfulWeapon() 
			} else
				super(target)
			weapons.forEach({ aWeapon => aWeapon.hasAttacked() })
		}

		method loseMostPowerfulWeapon() {
			var weaponToLose = weapons.max({ aWeapon => aWeapon.powerFor(this)}) 
			weapons.remove(weaponToLose)
		}
	}
	
	class Espada {
		var power
		
		constructor(aPower) { power = aPower }
		method powerFor(_) { return power }
	}
	
	class Equipo {
		var members
		
		constructor(_members){ members = _members}
		method members () = members
		method numberOfStandingMembers() {
			return this.standingMembers().size()
		}
		method standingMembers(){  
			return members.filter({aCharacter => aCharacter.isStanding()})
		}
		method attack(target){
			var attackers = this.standingMembers()
			if(attackers.isEmpty())
				throw new CannotAttackException("No attackers available")
			attackers.forEach({ aMember => aMember.attack(target) })
		}
		method receiveAttackOf(aPower){
			this.weakestMember().receiveAttackOf(aPower)
		}
		method weakestMember(){
			return this.standingMembers().min({aMember => aMember.offensivePower()})
		}
		method offensivePower(){
			return this.weakestMember().offensivePower()
		}
	}
	
	class CannotAttackException inherits Exception {
		constructor(_text){ 
			this.text(_text)
		}
	}
}
