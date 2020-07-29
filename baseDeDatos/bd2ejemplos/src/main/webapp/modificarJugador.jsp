<%@page import="java.util.Collection"%>
<%@page import="ar.edu.unq.bd2.tp.futbol.domain.Equipo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/modificarJugador">
		Nombre: <input type="text" name="nombre" value="${nombre}" />
		Apellido: <input type="text" name="apellido" value="${apellido}" />
		Equipo: 
		<select name="equipo">
		 <c:forEach var="currentEquipo" items="${equipos}">
				<option value="${currentEquipo.id}" ${currentEquipo.id != equipo ? 'selected' : ''}>
					 ${currentEquipo.nombre}				
				</option>
		</c:forEach>
		</select>
		<input type="hidden" name="id" value="${id}" />
		<input type="submit" value="aceptar" />
	</form>

</body>
</html>