package ar.edu.unq.bd2.tp.futbol.domain;

public class Jugador extends Persistible {

	private String nombre;
	private String apellido;
	private int idEquipo;

	public Jugador() {
	}
	
	
	public Jugador(int id, String nombre, String apellido, int idEquipo) {
		super(id);
		this.nombre = nombre;
		this.apellido = apellido;
		this.idEquipo = idEquipo;
	}


	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public int getIdEquipo() {
		return idEquipo;
	}

	public void setIdEquipo(int idEquipo) {
		this.idEquipo = idEquipo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String descripcion() {
		return apellido + ", " + nombre; 
	}
}
