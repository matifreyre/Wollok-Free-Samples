import ejercicio1.SmashBros.*

package SmashBros {
	object zelda {
		var armas = #{ espadaMaestra, boomerang, arcoYFlecha } 
		var poderBase = 50
		
		method poderBase() { return poderBase }
		
		method recibirAtaqueDe(potencia) { }
		
		method potencialOfensivo() {
			return this.poderBase() + armas.sum([ unArma | unArma.poderPara(this) ])
		}
		
		method atacarA(otro) {
			otro.recibirAtaqueDe(this.potencialOfensivo()) 
			if (this.potencialOfensivo() < otro.potencialOfensivo()) 
				this.perderArmaDeMasPoder() armas.forEach([
					unArma | unArma.atacaste() ])
		}
		
		method perderArmaDeMasPoder() {
			var armaAPerder = armas.max([ unArma | unArma.poderPara(this)]) 
			armas.remove(armaAPerder)
		}
	}
}