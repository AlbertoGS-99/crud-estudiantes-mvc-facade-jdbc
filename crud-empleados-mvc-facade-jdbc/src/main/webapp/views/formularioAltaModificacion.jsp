<%@page import="com.example.models.Carrera"%>
<%@page import="com.example.models.EstudianteUpdate"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduNet — Formulario de Estudiante</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<%
    EstudianteUpdate estudianteUpdate =
        (EstudianteUpdate) request.getAttribute("estudianteUpdate");
    boolean isEdit = estudianteUpdate != null && estudianteUpdate.id() != 0;
    String pageTitle = isEdit ? "Modificar Estudiante" : "Alta de Estudiante";
    String eyebrow   = isEdit ? "Editar registro" : "Nuevo registro";
%>

<!-- NAVBAR -->
<header class="navbar">
    <div class="navbar-left">
        <a href="index.jsp" class="logo">
            <svg width="26" height="26" viewBox="0 0 28 28" fill="none">
                <circle cx="14" cy="14" r="12" stroke="#00AAFF" stroke-width="2"/>
                <path d="M8 14 L14 8 L20 14 L14 20 Z" fill="#00AAFF"/>
                <circle cx="14" cy="14" r="3" fill="#fff"/>
            </svg>
            <span class="logo-text">EduNet</span>
        </a>
        <nav class="nav-links">
            <div class="nav-item"><a class="nav-btn" href="MainController">Estudiantes</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Carreras</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Asignaturas</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Matrículas</a></div>
        </nav>
    </div>
    <div class="navbar-right">
        <button class="nav-icon-btn account-btn">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            <span>Administrador</span>
        </button>
    </div>
</header>

<div class="page-wrapper">

    <!-- HERO -->
    <div class="page-hero">
        <div class="page-hero-eyebrow"><%= eyebrow %></div>
        <h1><%= pageTitle %></h1>
        <p>Completa los campos del formulario para <%= isEdit ? "actualizar los datos del" : "registrar un nuevo" %> estudiante en el sistema.</p>
    </div>

    <div class="content">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="index.jsp">Inicio</a>
            <span class="sep">›</span>
            <a href="MainController">Estudiantes</a>
            <span class="sep">›</span>
            <span><%= pageTitle %></span>
        </div>

        <!-- FORM -->
        <form action="AltaController" method="post">

            <input type="hidden" name="idEstudiante"
                value="<%= estudianteUpdate == null ? 0 : estudianteUpdate.id() %>">
            <input type="hidden" name="fechaRegistro"
                value="<%= estudianteUpdate != null ? estudianteUpdate.fechaRegistro() : "" %>">

            <div class="form-section">
                <div class="form-section-title">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                    Datos personales
                </div>

                <div class="form-grid">

                    <div class="form-group">
                        <label class="form-label" for="nombre">Nombre <span class="required">*</span></label>
                        <input class="form-input" type="text" id="nombre" name="nombre" required
                            placeholder="Nombre del estudiante"
                            value="<%= estudianteUpdate != null ? estudianteUpdate.nombre() : "" %>">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="apellidos">Apellidos <span class="required">*</span></label>
                        <input class="form-input" type="text" id="apellidos" name="apellidos" required
                            placeholder="Apellidos del estudiante"
                            value="<%= estudianteUpdate != null ? estudianteUpdate.apellidos() : "" %>">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email <span class="required">*</span></label>
                        <input class="form-input" type="email" id="email" name="email" required
                            placeholder="correo@universidad.es"
                            value="<%= estudianteUpdate != null ? estudianteUpdate.email() : "" %>">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="telefono">Teléfono</label>
                        <input class="form-input" type="text" id="telefono" name="telefono"
                            placeholder="+34 600 000 000"
                            value="<%= estudianteUpdate != null ? estudianteUpdate.telefono() : "" %>">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="fechaNacimiento">Fecha de nacimiento <span class="required">*</span></label>
                        <input class="form-input" type="date" id="fechaNacimiento" name="fechaNacimiento" required
                            value="<%= estudianteUpdate != null ? estudianteUpdate.fechaNacimiento() : "" %>">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="carrera">Carrera <span class="required">*</span></label>
                        <%
                            List<Carrera> carreras = (List<Carrera>) request.getAttribute("carreras");
                        %>
                        <select class="form-select" id="carrera" name="carrera" required>
                            <option value="">Selecciona una carrera…</option>
                            <%
                                for (Carrera carrera : carreras) {
                            %>
                                <option value="<%= carrera.id() %>"
                                    <%= estudianteUpdate != null &&
                                        estudianteUpdate.idCarrera() == carrera.id() ?
                                        "selected" : "" %>>
                                    <%= carrera.nombre() %>
                                </option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group span-2">
                        <label class="form-label">Estado <span class="required">*</span></label>
                        <div class="radio-group">
                            <label class="radio-label">
                                <input type="radio" name="activo" value="true" required
                                    <%= estudianteUpdate != null && estudianteUpdate.activo() ? "checked" : "" %>>
                                Activo
                            </label>
                            <label class="radio-label">
                                <input type="radio" name="activo" value="false" required
                                    <%= estudianteUpdate != null && !estudianteUpdate.activo() ? "checked" : "" %>>
                                Inactivo
                            </label>
                        </div>
                    </div>

                </div>

                <div class="form-actions">
                    <button class="btn-submit" type="submit">
                        <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/>
                        </svg>
                        <%= isEdit ? "Guardar cambios" : "Registrar estudiante" %>
                    </button>
                    <a href="MainController" class="btn-cancel">Cancelar</a>
                </div>

            </div>

        </form>
    </div>
</div>

<footer class="footer">
    <div class="footer-inner">
        <div class="footer-logo">
            <svg width="18" height="18" viewBox="0 0 28 28" fill="none"><circle cx="14" cy="14" r="12" stroke="#00AAFF" stroke-width="2"/><path d="M8 14 L14 8 L20 14 L14 20 Z" fill="#00AAFF"/><circle cx="14" cy="14" r="3" fill="#fff"/></svg>
            <span>EduNet</span>
        </div>
        <p class="footer-copy">&copy; 2026 EduNet &mdash; Sistema de Gestión Universitaria</p>
    </div>
</footer>

</body>
</html>
