package SmashBros {
	class Personaje {
		var danio = 0
		method danio(){ return danio }
		method danio(_danio){ danio = _danio}
		method recibirAtaqueDe(potencia) { danio += potencia }
		method estaFueraDeCombate(){ return danio > personaje.danioMaximo()}
		method estaEnPie(){ return !this.estaFueraDeCombate() }
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
			return armas.sum({ unArma => unArma.poderPara(this) })
		}

		override method atacarA(otro) {
			super(otro) 
			if (this.potencialOfensivo() < otro.potencialOfensivo()){
				super(otro)
				this.perderArmaDeMasPoder() 
			} else
				super(otro)
			armas.forEach({	unArma => unArma.atacaste() })
		}

		method perderArmaDeMasPoder() {
			var armaAPerder = armas.max({ unArma => unArma.poderPara(this)}) 
			armas.remove(armaAPerder)
		}
	}
	class Espada {
		var poder
		
		constructor(unPoder) { poder = unPoder }
		method poderPara(_) { return poder }
	}
	class Equipo {
		var integrantes = #{}
		
		constructor(_integrantes){ integrantes = _integrantes}
		method integrantes () { return integrantes }
		method cantidadDeIntegrantesEnPie() {
			return this.integrantesEnPie().size()
		}
		method integrantesEnPie(){  
			return integrantes.filter({unPersonaje => unPersonaje.estaEnPie()})
		}
		method atacarA(otro){
			var atacantes = this.integrantesEnPie()
			
			if(atacantes.isEmpty())
				throw new NoSePuedeAtacarException("No hay atacantes")
			this.integrantesEnPie().forEach({unIntegrante => unIntegrante.atacarA(otro)})	
		}
		method recibirAtaqueDe(potencia){
			this.integranteMasDebil().recibirAtaqueDe(potencia)
		}
		method integranteMasDebil(){
			return this.integrantesEnPie().min({unIntegrante => unIntegrante.potencialOfensivo()})
		}
		method potencialOfensivo(){
			return this.integranteMasDebil().potencialOfensivo()
		}
	}
	class NoSePuedeAtacarException inherits Exception {
		constructor(_text){ 
			this.text(_text)
		}
	}
}
