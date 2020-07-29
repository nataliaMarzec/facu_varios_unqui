package ar.edu.unq.bd2.tp.persistence;

import java.sql.Connection;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JugadoresCanjeStandalone {

	public static void main(String[] args) {
		new JugadoresCanjeStandalone().canjear(1, 4);

	}
	
	/**
	 * Metodo para intercambiar 2 jugadores, da inicio al requerimiento Abre y
	 * cierra la conexion
	 * 
	 * @throws RuntimeException
	 *             si salio algo mal (logica de negocio o SQLException)
	 * @param idJugador1
	 * @param idJugador2
	 */
	public void canjear(int idJugador1, int idJugador2) {

		// abre una coneccion que se cierra sola al terminar el try, no importa si
		// explota o no
		try (Connection conn = ConnectionManager.getInstance().newConnection()) {
			// setea que se quiere usar una transaccion
			conn.setAutoCommit(false);
			// llama a un metodo que maneja el commit/rollback
			// e invoca la logica de negocio y/o queries de DB
			// Si explota con una runtime falló la lógica de negocio
			// si explota con una SQLException pasó raro en el commit o rollback
			// que no se puede manejar
			this.canjearJugadoresTransaccionalmente(conn, idJugador1, idJugador2);
		}
		// Si falla con esta excepcion no hay nada importante que hacer, ya que
		// la transaccion la manejó el metodo canjearJugadoresTransaccionalmente
		// la "wrappeo" en una no chequeada y la vuelvo a lanzar
		catch (SQLException e) {
			throw new RuntimeException(e);
		}
		;

	}

	/**
	 * Metodo que maneja la transaccion e invoca la logica de negocio
	 * 
	 * @throws RuntimeExcepcion
	 *             si hubo un problema en la logica de negocio
	 * @SQLException si hubo un problema en el manejo transaccional
	 *               (commit/roolback)
	 * 
	 * @param conn
	 * @param idJugador1
	 * @param idJugador2
	 * @throws SQLException
	 */
	private void canjearJugadoresTransaccionalmente(Connection conn, int idJugador1, int idJugador2)
			throws SQLException {
		try {
			// llamo a la logica de negocio/queries.
			// Es importante que este metodo no tire SQLException, para que no
			// se mezcle con la excepciones que puede tirar el commit
			this.canjearJugadores(conn, idJugador1, idJugador2);
			// Commitea la transaccion, Si llamo a esa linea estoy seguro que las queries
			// de la logica de negocio anduvo bien, porque si no hubiera salido con una
			// RuntimeException
			// si falla el commit tira SQLException y no puedo hacer nada
			// la dejo que fluya hacia arriba.
			conn.commit();
		} catch (RuntimeException e) {
			// Si entró acá es porque falló la logica de negocio, entonces rollback.
			// Si falla el rollback sale con SQLException, y no puedo hacer al respecto
			// dejo que fluya hacia arriba
			conn.rollback();
			// Si falló la lógica de negocio, debe seguir subiendo la excepcion ya que
			// no se cumplio con la responsabilidad del canje
			throw e;
		}
	}

	/**
	 * Metodo con la logica de negocio
	 * 
	 * @throws RuntimeException
	 *             si salio mal algo (sea de SQL o no)
	 * 
	 * @param conn
	 * @param idJugador1
	 * @param idJugador2
	 */
	private void canjearJugadores(Connection conn, int idJugador1, int idJugador2) {
		// abro un try, porque cualquier problema de SQL que tire lo voy a convertir
		// en una excepcion no chequeada (runtime), de esa manera me facilita los
		// metodos
		// auxiliares para simplemente lanzar la SQLException hacia arriba, pero
		// al metodo que maneja la transaccion le llega una Runtime, de esa manera
		// sabe que si explota con una runtime tiene que hacer el roolbak y si no
		// explota
		// esta todo bien.
		try {
			int equipoJugador1 = this.buscarEquipo(conn, idJugador1);
			int equipoJugador2 = this.buscarEquipo(conn, idJugador2);
			this.cambiarEquipo(conn, idJugador1, equipoJugador2);
			this.cambiarEquipo(conn, idJugador2, equipoJugador1);

			// Descomentar esta linea si se quiere probar el rollback
			// throw new RuntimeException("Rompo a proposito");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	private int buscarEquipo(Connection conn, int idJugador) throws SQLException {
		// Crea la sentencia que se cierra sola al terminar el try haya roto o no
		try (PreparedStatement st = this.crearBuscarEquipoStatement(conn, idJugador);
				ResultSet rs = st.executeQuery()) {

			// chequea que haya un resultado y deja el resultSet listo para obtener la
			// informacion
			if (!rs.next()) {
				throw new RuntimeException("No se encontro el jugador de id " + idJugador);
			}

			return rs.getInt("equipo");
		}
	}

	private PreparedStatement crearBuscarEquipoStatement(Connection conn, int idJugador) throws SQLException {
		PreparedStatement st = conn.prepareStatement("Select equipo from Jugadores where id = ?");
		st.setInt(1, idJugador);
		return st;
	}

	private void cambiarEquipo(Connection conn, int idJugador, int equipoJugador) throws SQLException {
		try (PreparedStatement st = this.crearCambiarEquipoStatement(conn, idJugador, equipoJugador)) {
			if (st.executeUpdate() != 1) {
				throw new RuntimeException("No se modificó un único elemento");
			}
			;
		}
	}

	private PreparedStatement crearCambiarEquipoStatement(Connection conn, int idJugador, int equipoJugador)
			throws SQLException {
		PreparedStatement st = conn.prepareStatement("Update Jugadores set equipo = ? where id = ?");
		st.setInt(1, equipoJugador);
		st.setInt(2, idJugador);
		return st;
	}
}
