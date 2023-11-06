class Paciente {

	var edad
	var fortalezaMuscular
	var nivelDeDolor
	var rutina = []

	method getEdad() = edad

	method setfortalezaMuscular(nuevoValor) {
		fortalezaMuscular = nuevoValor
	}

	method getfortalezaMuscular() = fortalezaMuscular

	method setNivelDeDolor(nuevoValor) {
		nivelDeDolor = nuevoValor
	}

	method getNivelDeDolor() = nivelDeDolor

	method puedeUsar(aparato) {
	}

	method usarAparato(aparato) {
		aparato.serUsado(self)
	}

	method puedeRealizarRutina() = rutina.all({ aparato => self.puedeUsar(aparato) })

	method realizarSesionCompleta() {
		if (self.puedeRealizarRutina()) {
			rutina.forEach({ aparato => self.usarAparato(aparato)})
		} else {
			self.error("No puede realizarse la rutina")
		}
	}
	
	method agregarARutina(aparato){
		rutina.add(aparato)
	}

}

class Aparato {

	method serUsado(paciente)

	method puedeUsarse(paciente)

}

class Magneto inherits Aparato {

	// el nivel de dolor disminuye en un 10%. Puede ser usado por cualquier persona.
	override method serUsado(paciente) {
		paciente.setNivelDeDolor(paciente.getNivelDeDolor() * 0.9)
	}

	override method puedeUsarse(paciente) = true

}

class Bicicleta inherits Aparato {

	// el nivel de dolor disminuye en 4 puntos, 
	// mientras que la fortaleza muscular suma 3 puntos. Solo puede ser usado por personas mayores a 8 años.
	override method serUsado(paciente) {
		if (self.puedeUsarse(paciente)) {
			paciente.setNivelDeDolor(paciente.getNivelDeDolor() - 4)
			paciente.setfortalezaMuscular(paciente.getfortalezaMuscular() + 3)
		} else {
			self.error("La edad del paciente no permite el uso de este aparato")
		}
	}

	override method puedeUsarse(paciente) = paciente.getEdad() > 8

}

class Minitramp inherits Aparato {

	// El nivel de fortaleza muscular aumenta un 10% de la edad del paciente. 
	// Solo puede ser usado por personas cuyo nivel de dolor es inferior a 20.
	override method serUsado(paciente) {
		if (self.puedeUsarse(paciente)) {
			paciente.setfortalezaMuscular(paciente.getfortalezaMuscular() + paciente.getfortalezaMuscular() * 10 / 100)
		} else {
			self.error("El nivel de dolor del paciente no permite el uso de este aparato")
		}
	}

	override method puedeUsarse(paciente) = paciente.getNivelDeDolor() < 20

}

