package Dominio

import java.util.Calendar
import java.util.Date
import java.util.HashSet
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Entity
@Observable
@Accessors
class Busqueda {

	@Id
	@GeneratedValue
	private Long id

	@Column
	Date fechaRealizacion

	@ManyToOne()
	public Usuario quienBusca

	@ManyToMany()
	public Set<Vuelo> resultados = new HashSet

	@ManyToOne
	Aeropuerto origen
	
	@ManyToOne
	Aeropuerto destino
	
	@Column
	Date desdeFecha
	
	@Column
	Date hastaFecha
	
	@Column(length = 150)
	Double maxPrecio

	new(){}
	
	new(Aeropuerto inicio, Aeropuerto fin, Date desde, Date hasta, Double max, Usuario usr) {
		origen = inicio
		destino = fin
		desdeFecha = desde
		hastaFecha = hasta
		maxPrecio = max
		quienBusca = usr
		fechaRealizacion = Calendar.getInstance.getTime
	}

	def validacionFecha() {
		if (desdeFecha != null && hastaFecha != null) {
			if (desdeFecha > hastaFecha) {
				throw new UserException("La 'Fecha Desde' no puede ser menor que 'Fecha Hasta' ")
			}
		}
	}

	def realizadoPor(Usuario unUsr) {
		quienBusca == unUsr
	}
}
