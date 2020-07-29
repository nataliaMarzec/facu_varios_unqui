package ar.edu.unq.bd2.tp.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Statement;

import ar.edu.unq.bd2.tp.futbol.domain.Bandera;
import ar.edu.unq.bd2.tp.futbol.domain.Jugador;

public class JugadoresHome {

	private static JugadoresHome instance;

	public synchronized static JugadoresHome getInstance() {
		if (instance == null) {
			instance = new JugadoresHome();
		}
		return instance;
	}

	private JugadoresHome() {
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
	public void canjearJugadores(int idJugador1, int idJugador2) {
		// abro un try, porque cualquier problema de SQL que tire lo voy a convertir
		// en una excepcion no chequeada (runtime), de esa manera me facilita los
		// metodos
		// auxiliares para simplemente lanzar la SQLException hacia arriba, pero
		// al metodo que maneja la transaccion le llega una Runtime, de esa manera
		// sabe que si explota con una runtime tiene que hacer el roolbak y si no
		// explota
		// esta todo bien.
		try {
			int equipoJugador1 = this.buscarEquipo(idJugador1);
			int equipoJugador2 = this.buscarEquipo(idJugador2);
			this.cambiarEquipo(idJugador1, equipoJugador2);
			this.cambiarEquipo(idJugador2, equipoJugador1);

			// Descomentar esta linea si se quiere probar el rollback
			// throw new RuntimeException("Rompo a proposito");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	private int buscarEquipo(int idJugador) throws SQLException {
		// Crea la sentencia que se cierra sola al terminar el try haya roto o no
		try (PreparedStatement st = this.crearBuscarEquipoStatement(idJugador); ResultSet rs = st.executeQuery()) {

			// chequea que haya un resultado y deja el resultSet listo para obtener la
			// informacion
			if (!rs.next()) {
				throw new RuntimeException("No se encontro el jugador de id " + idJugador);
			}

			return rs.getInt("equipo");
		}
	}

	private PreparedStatement crearBuscarEquipoStatement(int idJugador) throws SQLException {
		Connection conn = ConnectionManager.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("Select equipo from Jugadores where id = ?");
		st.setInt(1, idJugador);
		return st;
	}

	private void cambiarEquipo(int idJugador, int equipoJugador) throws SQLException {
		try (PreparedStatement st = this.crearCambiarEquipoStatement(idJugador, equipoJugador)) {
			if (st.executeUpdate() != 1) {
				throw new RuntimeException("No se modificó un único elemento");
			}
			;
		}
	}

	private PreparedStatement crearCambiarEquipoStatement(int idJugador, int equipoJugador) throws SQLException {
		Connection conn = ConnectionManager.getInstance().getConnection();
		PreparedStatement st = conn.prepareStatement("Update Jugadores set equipo = ? where id = ?");
		st.setInt(1, equipoJugador);
		st.setInt(2, idJugador);
		return st;
	}

	public List<Jugador> all() {
		// Crea la sentencia que se cierra sola al terminar el try haya roto o no
		try (PreparedStatement st = this.crearAllStatement(); ResultSet rs = st.executeQuery()) {

			List<Jugador> out = new ArrayList<>();
			while (rs.next()) {
				out.add(new Jugador(rs.getInt("id"), rs.getString("nombre"), rs.getString("apellido"),
						rs.getInt("equipo")));
			}

			return out;
		}
		catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	private PreparedStatement crearAllStatement() throws SQLException {
		return ConnectionManager.getInstance().getConnection().prepareStatement("Select * from Jugadores");

	}

	public Jugador find(int idJugador) {
		// Crea la sentencia que se cierra sola al terminar el try haya roto o no
		try (PreparedStatement st = this.crearFindStatement(idJugador); 
				ResultSet rs = st.executeQuery()) {

			// chequea que haya un resultado y deja el resultSet listo para obtener la
			// informacion
			if (!rs.next()) {
				throw new RuntimeException("No se encontro el jugador de id " + idJugador);
			}

			return new Jugador(idJugador, rs.getString("nombre"), rs.getString("apellido"), rs.getInt("equipo"));
		}
		catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	private PreparedStatement crearFindStatement(int idJugador) throws SQLException {
		PreparedStatement st = ConnectionManager.getInstance().getConnection().prepareStatement("Select * from Jugadores where id = ?");
		st.setInt(1, idJugador);
		return st;
	}

	public void update(Jugador jugador) {
		try(PreparedStatement st = prepareUpdateStatement(jugador);
					){
				int modified = st.executeUpdate();
				if(modified != 1) {
					throw new RuntimeException("Se modificaron " + modified + "filas. Se esperaba 1");
				};
		}
		catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}
	private PreparedStatement prepareUpdateStatement(Jugador jugador) throws SQLException {
		PreparedStatement st = ConnectionManager.getInstance().getConnection().prepareStatement(
				" Update Jugadores Set " +
				" nombre = ? , apellido = ? , equipo = ? " +
			    " where id = ?");
		st.setString(1, jugador.getNombre());
		st.setString(2, jugador.getApellido());
		st.setInt(3, jugador.getIdEquipo());
		st.setInt(4, jugador.getId());
		
		return st;
	}


}
