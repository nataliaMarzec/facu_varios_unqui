package ar.edu.unq.bd2.tp.futbol.domain;

public class Bandera extends Persistible {

	private String colorPrimario;
	private String colorSecundario;

	public Bandera() {
		super();
	}

	public Bandera(int id, String nombre, String apellido) {
		super(id);
		this.setColorSecundario(apellido);
		this.setColorPrimario(nombre);
	}

	public String getColorPrimario() {
		return colorPrimario;
	}

	public void setColorPrimario(String nombre) {
		this.colorPrimario = nombre;
	}

	public String getColorSecundario() {
		return colorSecundario;
	}

	public void setColorSecundario(String apellido) {
		this.colorSecundario = apellido;
	}
	
}
