package ar.edu.unq.bd2.tp.persistence;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.ConnectionFactory;
import org.apache.commons.dbcp2.DriverManagerConnectionFactory;
import org.apache.commons.dbcp2.PoolableConnection;
import org.apache.commons.dbcp2.PoolableConnectionFactory;
import org.apache.commons.dbcp2.PoolingDataSource;
import org.apache.commons.pool2.ObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPool;

public class ConnectionManager {

	private final String connectionString = "jdbc:mysql://localhost/futbol";
	private final String driver = "com.mysql.jdbc.Driver";
	private final String user = "pepe";
	private final String pass = "pepe";
	
	static ConnectionManager instance;
	
	//Es el encargado de construir las conecciones. El pool está detrás de este objeto
	private DataSource dataSource;

	// Sabe guardar un valor para un Thread dado. de esta manera
	// podemos guardar una coneccion para cada usuario de la app
	// y accederla siempre que se quiera
	private ThreadLocal<Connection> store = new ThreadLocal<Connection>();	

	
	private ConnectionManager() {
		this.loadDriver();
		 dataSource = this.createDataSource(connectionString, user, pass);
	}
	
	private void loadDriver() {
		// Esto levanta el driver
		try {
			Class.forName(this.driver);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Este método crea un DataSource. 
	 * La interface es complemante a nivel JDBC (recibe string y devuelve un dataSource de JDBC
	 * Pero la implementación usa cosas espećificas de commons-dbcp.
	 * Para usar otra implementación, por ejemplo C3P0, se debe cambiar
	 * la implementación de este método.
	 * @return
	 */
	public DataSource createDataSource(String connectionString,String user, String pass) {
		
		ConnectionFactory connectionFactory =
				new DriverManagerConnectionFactory(connectionString, user, pass);
		
		
		PoolableConnectionFactory poolableConnectionFactory =
				new PoolableConnectionFactory(connectionFactory, null);
		
		
		ObjectPool<PoolableConnection> connectionPool =
				new GenericObjectPool<>(poolableConnectionFactory);
		
		poolableConnectionFactory.setPool(connectionPool);
		
		PoolingDataSource<PoolableConnection> dataSource =
				new PoolingDataSource<>(connectionPool);
		
		return dataSource;		
	}
	
	public static synchronized ConnectionManager getInstance() {
		if(instance == null) {
			instance = new ConnectionManager();
		}
		return instance;
	}
	
	
	public Connection newConnection() {
		try {
			return dataSource.getConnection();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public Connection getConnection() {
		return store.get();
	}

	public Connection openConnection() {
		try {
			Connection conn = this.newConnection();
			//pide manejar la transaccion
			conn.setAutoCommit(false);
			// Lo guarda en el threadLocal
			store.set(conn);
			return conn;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
}
































