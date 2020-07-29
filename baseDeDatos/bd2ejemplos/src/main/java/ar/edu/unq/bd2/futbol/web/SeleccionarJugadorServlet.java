package ar.edu.unq.bd2.futbol.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ar.edu.unq.bd2.tp.persistence.JugadoresHome;

public class SeleccionarJugadorServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		req.setAttribute("jugadores", JugadoresHome.getInstance().all());
		getServletContext().getRequestDispatcher("/seleccionJugador.jsp").forward(req, resp);
	}
}
