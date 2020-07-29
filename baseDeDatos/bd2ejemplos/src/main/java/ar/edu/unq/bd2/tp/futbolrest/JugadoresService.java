package ar.edu.unq.bd2.tp.futbolrest;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;


import ar.edu.unq.bd2.tp.futbol.domain.Canje;
import ar.edu.unq.bd2.tp.persistence.JugadoresHome;

@Path("jugadores")
public class JugadoresService {


	@PUT()
	@Path("canjear")
	@Consumes(MediaType.APPLICATION_JSON)
	public void canjear(Canje canje) {
		JugadoresHome.getInstance().canjearJugadores(canje.getJugador1(), canje.getJugador2());
	}
	


}
