package ar.edu.unq.bd2.futbol.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ar.edu.unq.bd2.tp.futbol.domain.Equipo;
import ar.edu.unq.bd2.tp.futbol.domain.Jugador;
import ar.edu.unq.bd2.tp.persistence.EquipoHome;
import ar.edu.unq.bd2.tp.persistence.JugadoresHome;

public class MostrarDatosJugadorServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		 int idJugador =Integer.parseInt(req.getParameter("jugador"));
		 Jugador jugador = JugadoresHome.getInstance().find(idJugador);
		 List<Equipo> equipos = EquipoHome.getInstance().all();
		 req.setAttribute("id", jugador.getId());
		 req.setAttribute("nombre", jugador.getNombre());
		 req.setAttribute("apellido", jugador.getApellido());
		 req.setAttribute("equipo", jugador.getIdEquipo());
		 req.setAttribute("equipos", equipos);
		 
		 this.getServletContext().getRequestDispatcher("/modificarJugador.jsp").forward(req, resp);
		 
	}
}
