<%@page import="com.example.models.Carrera"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Formulario</title>
</head>
<body>
    <h1>Formulario de Alta/Modificacion de Estudiante</h1>
    <fieldset>
        <legend>Formulario de Gestión de Estudiante</legend>
        <form action="AltaController" method="post">
            <div>
                <label for="nombre">Nombre: </label>
                <input type="text" id="nombre" name="nombre" required placeholder="Su nombre aquí">
            </div>
            <div>
                <label for="apellidos">Apellidos: </label>
                <input type="text" id="apellidos" name="apellidos" required placeholder="Sus apellidos aquí">
            </div>
            <div>
                <label for="email">Email: </label>
                <input type="email" id="email" name="email" required placeholder="Su email aquí">
            </div>
            <div>
                <label for="telefono">Teléfono: </label>
                <input type="text" id="telefono" name="telefono" placeholder="Su teléfono aquí">
            </div>
            <div>
                <label for="fechaNacimiento">Fecha de Nacimiento: </label>
                <input type="date" id="fechaNacimiento" name="fechaNacimiento" required>
            </div>
            <div>
                <fieldset>
                    <legend>Activo</legend>
                    <label for="activo_si">Sí: </label>
                    <input type="radio" id="activo_si" name="activo" value="true" required>
                    <label for="activo_no">No: </label>
                    <input type="radio" id="activo_no" name="activo" value="false" required>
                </fieldset>
            </div>
            <div>
                <%
                    List<Carrera> carreras = (List<Carrera>) request.getAttribute("carreras");
                %>
                <label for="carrera">Carrera: </label>
                <select id="carrera" name="carrera" required>
                    <option></option>
                    <%
                        for (Carrera carrera : carreras) {
                    %>
                        <option value="<%= carrera.id() %>"><%= carrera.nombre() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <br>
            <input type="submit" value="Enviar">
        </form>
    </fieldset>
</body>
</html>