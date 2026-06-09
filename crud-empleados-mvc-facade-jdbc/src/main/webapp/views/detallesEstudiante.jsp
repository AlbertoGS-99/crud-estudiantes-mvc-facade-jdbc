<%@page import="com.example.models.Detalle"%>
<%@page import="com.example.models.Estudiante"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduNet — Detalle del Estudiante</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<%
    Estudiante estudiante = (Estudiante) request.getAttribute("estudiante");
    Detalle    detalles   = (Detalle)    request.getAttribute("detalles");
    String nombreCompleto = estudiante.nombre() + " " + estudiante.apellidos();
    // Iniciales para el avatar (primeras letras de nombre y primer apellido)
    String[] partes   = nombreCompleto.trim().split("\\s+");
    String iniciales  = partes.length >= 2
        ? ("" + partes[0].charAt(0) + partes[1].charAt(0)).toUpperCase()
        : nombreCompleto.substring(0, Math.min(2, nombreCompleto.length())).toUpperCase();
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
        <div class="page-hero-eyebrow">Expediente académico</div>
        <h1><%= nombreCompleto %></h1>
        <p>Información detallada del estudiante: carrera, asignaturas matriculadas y años académicos.</p>
    </div>

    <div class="content">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="index.jsp">Inicio</a>
            <span class="sep">›</span>
            <a href="MainController">Estudiantes</a>
            <span class="sep">›</span>
            <span><%= nombreCompleto %></span>
        </div>

        <!-- DETAIL LAYOUT -->
        <div class="detail-layout">

            <!-- Profile sidebar -->
            <aside class="profile-card">
                <div class="profile-avatar"><%= iniciales %></div>
                <div class="profile-name"><%= nombreCompleto %></div>
                <div class="profile-carrera"><%= detalles.nombreCarrera() %></div>

                <div class="profile-divider"></div>

                <div class="profile-meta">
                    <div class="meta-row">
                        <span class="meta-label">ID de estudiante</span>
                        <span class="meta-value">#<%= estudiante.id() %></span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Carrera</span>
                        <span class="meta-value"><%= detalles.nombreCarrera() %></span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Asignaturas</span>
                        <span class="meta-value"><%= detalles.asignaturas().size() %> matriculadas</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Años académicos</span>
                        <span class="meta-value"><%= detalles.matriculas().size() %></span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Estado</span>
                        <span class="meta-value">
                            <span class="badge <%= estudiante.activo() ? "badge-active" : "badge-inactive" %>">
                                <span class="badge-dot"></span>
                                <%= estudiante.activo() ? "Activo" : "Inactivo" %>
                            </span>
                        </span>
                    </div>
                </div>
            </aside>

            <!-- Detail panels -->
            <div class="detail-panels">

                <!-- Asignaturas -->
                <div class="detail-panel">
                    <div class="panel-header">
                        <div class="panel-header-icon">
                            <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                            </svg>
                        </div>
                        <span class="panel-title">Asignaturas matriculadas</span>
                        <span class="panel-count"><%= detalles.asignaturas().size() %> total</span>
                    </div>
                    <ul class="panel-list">
                        <%
                            if (detalles.asignaturas().isEmpty()) {
                        %>
                            <li style="color: var(--text-muted); font-style: italic;">Sin asignaturas registradas</li>
                        <%
                            } else {
                                for (String asignatura : detalles.asignaturas()) {
                        %>
                            <li>
                                <span class="list-bullet"></span>
                                <%= asignatura %>
                            </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>

                <!-- Años académicos -->
                <div class="detail-panel">
                    <div class="panel-header">
                        <div class="panel-header-icon">
                            <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/>
                            </svg>
                        </div>
                        <span class="panel-title">Años académicos</span>
                        <span class="panel-count"><%= detalles.matriculas().size() %> períodos</span>
                    </div>
                    <ul class="panel-list">
                        <%
                            if (detalles.matriculas().isEmpty()) {
                        %>
                            <li style="color: var(--text-muted); font-style: italic;">Sin matrículas registradas</li>
                        <%
                            } else {
                                for (String anio : detalles.matriculas()) {
                        %>
                            <li>
                                <span class="list-bullet"></span>
                                <%= anio %>
                            </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>

            </div>
        </div>

        <!-- ACTIONS -->
        <div class="detail-actions">
            <a href="MainController" class="btn-outline">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="m15 18-6-6 6-6"/></svg>
                Volver al listado
            </a>
            <a href="UpdateController?idEstudiante=<%= estudiante.id() %>" class="btn-edit">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                </svg>
                Modificar estudiante
            </a>
        </div>

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
