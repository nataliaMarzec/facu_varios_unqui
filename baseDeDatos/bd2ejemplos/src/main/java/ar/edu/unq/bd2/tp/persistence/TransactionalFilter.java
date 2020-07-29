package ar.edu.unq.bd2.tp.persistence;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class TransactionalFilter implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		try(Connection conn = ConnectionManager.getInstance().openConnection()) {
			this.manageTransaction(conn, request,response,chain);
		} 
		catch (SQLException e) {
			throw new ServletException(e);
		}
	}

	private void manageTransaction(Connection conn, ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException, SQLException {

		try {
			chain.doFilter(request, response);
			conn.commit();
		}
		catch(RuntimeException | ServletException | IOException e) {
			conn.rollback();
			throw e;
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
