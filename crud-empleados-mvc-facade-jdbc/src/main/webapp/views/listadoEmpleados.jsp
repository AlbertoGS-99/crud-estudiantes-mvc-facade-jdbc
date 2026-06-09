<%@page import="com.example.models.Estudiante"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Estudiantes</title>
</head>
<body>
    <%
        List<Estudiante> estudiantes = (List<Estudiante>) request.getAttribute("estudiantes");
    %>
    <h1>Listado de Estudiantes</h1>

    <div>
        <a href="AltaController">Alta de Estudiante</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Email</th>
                <th>Teléfono</th>
                <th>Fecha Nacimiento</th>
                <th>Activo</th>
                <th>Detalles</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Estudiante estudiante : estudiantes) {
            %>
                <tr>
                    <td><%= estudiante.nombre() %></td>
                    <td><%= estudiante.apellidos() %></td>
                    <td><%= estudiante.email() %></td>
                    <td><%= estudiante.telefono() %></td>
                    <td><%= estudiante.fechaNacimiento() %></td>
                    <td><%= estudiante.activo() %></td>
                    <td><a href="DetallesController?idEstudiante=<%= estudiante.id() %>">Detalles</a></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>