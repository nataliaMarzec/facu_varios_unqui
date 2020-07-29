package ar.edu.unq.bd2.tp.persistence;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ar.edu.unq.bd2.tp.futbol.domain.Equipo;
import ar.edu.unq.bd2.tp.futbol.domain.Jugador;

public class EquipoHome {

	static EquipoHome instance;
	
	private EquipoHome() {
	}
	
	public static synchronized EquipoHome getInstance() {
		if(instance == null) {
			instance = new EquipoHome();
		}
		return instance;
	}
	
	public List<Equipo> all() {
			// Crea la sentencia que se cierra sola al terminar el try haya roto o no
			try (PreparedStatement st = this.crearAllStatement(); ResultSet rs = st.executeQuery()) {

				List<Equipo> out = new ArrayList<>();
				while (rs.next()) {
					out.add(new Equipo(rs.getInt("id"), rs.getString("nombre")));
				}

				return out;
			}
			catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}

	private PreparedStatement crearAllStatement() throws SQLException {
		return ConnectionManager.getInstance().getConnection().prepareStatement("Select * from Equipos");

	}


	
	
}
