package SmashBros {
	class Personaje {
		var danio = 0
		method danio(){ return danio }
		method recibirAtaqueDe(potencia) { danio += potencia }
		method estaFueraDeCombate(){ return danio > personaje.danioMaximo()}
		method potencialOfensivo()
		method atacarA(otro) {
			otro.recibirAtaqueDe(this.potencialOfensivo())
		}
	} 
	object personaje {
		var danioMaximo = 200
		method danioMaximo() {return danioMaximo}
		method danioMaximo(_danioMaximo) {danioMaximo = _danioMaximo}
	}
	object captainFalcon inherits Personaje {
		override method potencialOfensivo() {
			return 9999
		}
	} 
	object jigglypuff inherits Personaje {
		var potencialOfensivo = 250
		override method potencialOfensivo() {
			return potencialOfensivo
		}
		override method atacarA(otro) {
			otro.recibirAtaqueDe(this.potencialOfensivo()) potencialOfensivo =
			potencialOfensivo / 2
		}
	}
	object link inherits Personaje {
		var poderBase = 100
		var arma
		override method potencialOfensivo() {
			return poderBase + arma.poderPara(this)
		}
		override method atacarA(otro) {
			super(otro) 
			arma.atacaste()
		}
		method poderBase() { return poderBase }
		method arma(_arma) { arma = _arma }
	}
	object espadaMaestra {
		method poderPara(_) { return 100 }
		method atacaste() { }
	}

	object boomerang {
		method poderPara(portador) { return portador.poderBase() }
		method atacaste() { }
	}

	object arcoYFlecha {
		var cantidadDeFlechas = 10
		method poderPara(_) { return cantidadDeFlechas * 5 }
		method atacaste() { cantidadDeFlechas -= 1 }
	}
	object zelda inherits Personaje {
		var armas = #{ espadaMaestra , boomerang , arcoYFlecha } 
		var poderBase = 50

		method poderBase() { return poderBase }

		override method potencialOfensivo() { 
			return this.poderBase() + this.poderDeArmas()
		}
		
		method poderDeArmas(){
			return armas.sum([ unArma | unArma.poderPara(this) ])
		}

		override method atacarA(otro) {
			super(otro) 
			if (this.potencialOfensivo() < otro.potencialOfensivo()) 
				this.perderArmaDeMasPoder() 
			armas.forEach([	unArma | unArma.atacaste() ])
		}

		method perderArmaDeMasPoder() {
			var armaAPerder = armas.max([ unArma | unArma.poderPara(this)]) 
			armas.remove(armaAPerder)
		}
	}
	class Espada {
		var poder
		new(unPoder) { poder = unPoder }
		method poderPara(_) { return poder }
	}
}