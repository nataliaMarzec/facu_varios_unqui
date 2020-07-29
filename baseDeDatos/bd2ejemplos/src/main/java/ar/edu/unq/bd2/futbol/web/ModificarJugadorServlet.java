package ar.edu.unq.bd2.futbol.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ar.edu.unq.bd2.tp.futbol.domain.Jugador;
import ar.edu.unq.bd2.tp.persistence.JugadoresHome;

public class ModificarJugadorServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		JugadoresHome.getInstance().update(
				new Jugador(
						Integer.parseInt(req.getParameter("id")),
					    req.getParameter("nombre"), 
					    req.getParameter("apellido"),
					    Integer.parseInt(req.getParameter("equipo"))));
		
		resp.sendRedirect("/index.jsp");
	
	}
	
}
