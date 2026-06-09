<%@page import="com.example.models.Carrera"%>
<%@page import="com.example.models.EstudianteUpdate"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Formulario</title>
</head>
<body>
    <%
        EstudianteUpdate estudianteUpdate = (EstudianteUpdate) request.getAttribute("estudianteUpdate");
    %>
    <h1>Formulario de Alta/Modificacion de Estudiante</h1>

    <fieldset>
        <legend>Formulario de Gestión de Estudiante</legend>
        <form action="AltaController" method="post">

            <input type="hidden" name="idEstudiante"
                value="<%= estudianteUpdate == null ? 0 : estudianteUpdate.id() %>">

            <!-- fechaRegistro oculta para conservarla en modificacion -->
            <input type="hidden" name="fechaRegistro"
                value="<%= estudianteUpdate != null ? estudianteUpdate.fechaRegistro() : '' %>">

            <div>
                <label for="nombre">Nombre: </label>
                <input type="text" id="nombre" name="nombre" required
                    placeholder="Su nombre aquí"
                    value="<%= estudianteUpdate != null ? estudianteUpdate.nombre() : ' ' %>">
            </div>
            <div>
                <label for="apellidos">Apellidos: </label>
                <input type="text" id="apellidos" name="apellidos" required
                    placeholder="Sus apellidos aquí"
                    value="<%= estudianteUpdate != null ? estudianteUpdate.apellidos() : ' ' %>">
            </div>
            <div>
                <label for="email">Email: </label>
                <input type="email" id="email" name="email" required
                    placeholder="Su email aquí"
                    value="<%= estudianteUpdate != null ? estudianteUpdate.email() : ' ' %>">
            </div>
            <div>