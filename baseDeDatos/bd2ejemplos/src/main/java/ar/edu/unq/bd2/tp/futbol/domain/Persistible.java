package ar.edu.unq.bd2.tp.futbol.domain;

public class Persistible {

	private int id;

	public Persistible() {
	}

	public Persistible(int id) {
		this.setId(id);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
}
