<%@page import="ar.edu.unq.bd2.tp.futbol.domain.Jugador"%>
<%@page import="java.util.Collection"%>
<%@page import="ar.edu.unq.bd2.tp.futbol.domain.Bandera"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Seleccione el jugador</title>
</head>
<body>

	<form method="GET" action="/mostrarDatos" >
		Seleccione el Jugador a modificar:
		<select name="jugador">
		<c:forEach var="jugador" items="${jugadores}">
				<option value="${jugador.id}">${jugador.descripcion()} </option>
		</c:forEach>
		</select>	
		<input type="submit" value="aceptar" />
	</form>


</body>
</html>