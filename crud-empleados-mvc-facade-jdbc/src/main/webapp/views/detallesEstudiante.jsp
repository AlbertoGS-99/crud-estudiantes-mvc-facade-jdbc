<%@page import="com.example.models.Detalle"%>
<%@page import="com.example.models.Estudiante"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detalles del Estudiante</title>
</head>
<body>
    <%
        Estudiante estudiante = (Estudiante) request.getAttribute("estudiante");
        Detalle detalles      = (Detalle)    request.getAttribute("detalles");
    %>

    <h1>Detalles del estudiante: <%= estudiante.nombre() + " " + estudiante.apellidos() %></h1>

    <h3>Carrera: <%= detalles.nombreCarrera() %></h3>

    <div>
        <h3>Asignaturas matriculadas:</h3>
        <ul>
            <%
                for (String asignatura : detalles.asignaturas()) {
            %>
                <li><%= asignatura %></li>
            <%
                }
            %>
        </ul>
    </div>

    <div>
        <h3>Años académicos:</h3>
        <ul>
            <%
                for (String anio : detalles.matriculas()) {
            %>
                <li><%= anio %></li>
            <%
                }
            %>
        </ul>
    </div>

    <br>
    <a href="MainController">Volver al listado</a>
    <a href="UpdateController?idEstudiante=<%= estudiante.id() %>">Modificar estudiante</a>
</body>
</html>