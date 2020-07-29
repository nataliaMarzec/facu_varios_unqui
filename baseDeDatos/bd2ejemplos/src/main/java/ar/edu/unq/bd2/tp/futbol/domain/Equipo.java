package ar.edu.unq.bd2.tp.futbol.domain;

public class Equipo extends Persistible{

	private String nombre;

	public Equipo(int id, String nombre) {
		super(id);
		this.nombre = nombre;
	}
	
	public Equipo() {
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
}
