package SmashBros {
	object captainFalcon {
		method potencialOfensivo() {
			return 9999
		}
		method atacarA(otro) {
			otro.recibirAtaqueDe(this.potencialOfensivo())
		}
		method recibirAtaqueDe(potencia){}
	}
	object jigglypuff {
		var potencialOfensivo = 250
		method potencialOfensivo() {
			return potencialOfensivo
		}
		method atacarA(otro) {
			otro.recibirAtaqueDe(this.potencialOfensivo()) 
			potencialOfensivo = potencialOfensivo / 2
		}
		method recibirAtaqueDe(potencia){}
	}
	object link {
		var poderBase = 100
		var arma
		method potencialOfensivo() {
			return poderBase + arma.poderPara(this)
		}
		method atacarA(otro) {
			otro.recibirAtaqueDe(this.potencialOfensivo()) 
			arma.atacaste()
		}
		method poderBase() { return poderBase }
		method setArma(unArma) { arma = unArma }
		method recibirAtaqueDe(potencia){}
	}
	object espadaMaestra {
		method poderPara(portador) { return 100 }
		method atacaste() { }
	}

	object boomerang {
		method poderPara(portador) { return portador.poderBase() }
		method atacaste() { }
	}

	object arcoYFlecha {
		var cantidadDeFlechas = 10
		method poderPara(portador) { return cantidadDeFlechas * 5 }
		method atacaste() { cantidadDeFlechas -= 1 }
	}
}