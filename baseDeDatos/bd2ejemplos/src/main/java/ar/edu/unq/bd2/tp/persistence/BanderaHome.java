package ar.edu.unq.bd2.tp.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import ar.edu.unq.bd2.tp.futbol.domain.Bandera;

public class BanderaHome {

	private static BanderaHome instance;
	
	private BanderaHome() {};
	public synchronized static BanderaHome getInstance() {
		if(instance == null) {
			instance = new BanderaHome();
		}
		return instance;
	}
	
	public Bandera find(String equipo) {
		try(Connection connection = ConnectionManager.getInstance().newConnection();
			PreparedStatement st = prepareFindEquipoStatementStatement(connection, equipo);
			ResultSet rs = st.executeQuery();	){
			
			if(! rs.next()) {
				throw new RuntimeException("No se encontró la bandera para el quipo");
			}
			return new Bandera(rs.getInt("id"), 
							   rs.getString("color_primario"), 
							   rs.getString("color_secundario"));
		}
		catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}

	private PreparedStatement prepareFindEquipoStatementStatement(Connection connection, String equipo) throws SQLException {
		PreparedStatement st = connection.prepareStatement(
				"Select Banderas.id, Banderas.color_primario, Banderas.color_secundario"  +
				" from Banderas join Equipos on Banderas.id = Equipos.id" +
				" where Equipos.nombre like ?");
		st.setString(1, equipo);
		return st;
	}

	public void update(Bandera bandera) {
		try(Connection connection = ConnectionManager.getInstance().newConnection();
				PreparedStatement st = prepareUpdateEquipoStatementStatement(connection, bandera);
					){
				int modified = st.executeUpdate();
				if(modified != 1) {
					throw new RuntimeException("Se modificaron " + modified + "columnas. Se esperaba 1");
				};
		}
		catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}
	private PreparedStatement prepareUpdateEquipoStatementStatement(Connection connection, Bandera bandera) throws SQLException {
		PreparedStatement st = connection.prepareStatement(
				" Update Banderas Set " +
				" color_primario = ? , color_secundario = ? " +
			    " where id = ?");
		st.setString(1, bandera.getColorPrimario());
		st.setString(2, bandera.getColorSecundario());
		st.setInt(3, bandera.getId());
		
		return st;
	}
	
}
