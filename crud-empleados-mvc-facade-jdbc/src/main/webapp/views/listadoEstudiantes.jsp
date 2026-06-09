<%@page import="com.example.models.Estudiante"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduNet — Listado de Estudiantes</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<%
    List<Estudiante> estudiantes = (List<Estudiante>) request.getAttribute("estudiantes");
    int total = (estudiantes != null) ? estudiantes.size() : 0;
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
            <div class="nav-item"><a class="nav-btn" style="color:#fff" href="MainController">Estudiantes</a></div>
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
        <div class="page-hero-eyebrow">Gestión académica</div>
        <h1>Listado de Estudiantes</h1>
        <p>Consulta, filtra y gestiona todos los estudiantes registrados en el sistema universitario.</p>
    </div>

    <div class="content">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="index.jsp">Inicio</a>
            <span class="sep">›</span>
            <span>Estudiantes</span>
        </div>

        <!-- TOOLBAR -->
        <div class="table-toolbar">
            <div class="table-toolbar-left">
                <div class="search-wrap">
                    <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
                    </svg>
                    <input class="search-input" type="text" id="searchInput"
                        placeholder="Buscar por nombre, apellidos…"
                        oninput="filtrarTabla(this.value)">
                </div>
                <span class="table-count" id="countLabel"><%= total %> estudiante<%= total != 1 ? "s" : "" %></span>
            </div>
            <a href="AltaController" class="btn-add">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                Nuevo estudiante
            </a>
        </div>

        <!-- TABLE -->
        <div class="table-wrap">
            <table class="data-table" id="studentsTable">
                <thead>
                    <tr>
                        <th>Estudiante</th>
                        <th>Teléfono</th>
                        <th>F. Nacimiento</th>
                        <th>F. Registro</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (estudiantes == null || estudiantes.isEmpty()) {
                %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <div class="empty-state-icon">👤</div>
                                <p>No hay estudiantes registrados en el sistema.</p>
                            </div>
                        </td>
                    </tr>
                <%
                    } else {
                        for (Estudiante est : estudiantes) {
                            String nombre   = est.nombre();
                            String apellidos = est.apellidos();
                            String[] partes  = (nombre + " " + apellidos).trim().split("\\s+");
                            String iniciales = partes.length >= 2
                                ? ("" + partes[0].charAt(0) + partes[1].charAt(0)).toUpperCase()
                                : nombre.substring(0, Math.min(2, nombre.length())).toUpperCase();
                %>
                    <tr>
                        <td>
                            <div class="student-chip">
                                <div class="avatar"><%= iniciales %></div>
                                <div>
                                    <div class="student-name"><%= nombre %> <%= apellidos %></div>
                                    <div class="student-email"><%= est.email() %></div>
                                </div>
                            </div>
                        </td>
                        <td><%= est.telefono() != null && !est.telefono().isEmpty() ? est.telefono() : "—" %></td>
                        <td><%= est.fechaNacimiento() %></td>
                        <td><%= est.fechaRegistro() %></td>
                        <td>
                            <span class="badge <%= est.activo() ? "badge-active" : "badge-inactive" %>">
                                <span class="badge-dot"></span>
                                <%= est.activo() ? "Activo" : "Inactivo" %>
                            </span>
                        </td>
                        <td>
                            <div class="table-actions">
                                <!-- Ver detalle -->
                                <a href="DetalleController?idEstudiante=<%= est.id() %>" class="action-btn" title="Ver detalle">
                                    <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>
                                    </svg>
                                </a>
                                <!-- Editar -->
                                <a href="UpdateController?idEstudiante=<%= est.id() %>" class="action-btn" title="Editar">
                                    <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                                    </svg>
                                </a>
                                <!-- Eliminar -->
                                <a href="DeleteController?idEstudiante=<%= est.id() %>"
                                    class="action-btn delete" title="Eliminar"
                                    onclick="return confirm('¿Eliminar a <%= nombre %> <%= apellidos %>?')">
                                    <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                        <polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/>
                                        <path d="M10 11v6M14 11v6"/><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/>
                                    </svg>
                                </a>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
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

<script>
function filtrarTabla(query) {
    const q = query.toLowerCase().trim();
    const rows = document.querySelectorAll('#studentsTable tbody tr');
    let visible = 0;
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        const match = text.includes(q);
        row.style.display = match ? '' : 'none';
        if (match) visible++;
    });
    const label = document.getElementById('countLabel');
    if (label) label.textContent = visible + ' estudiante' + (visible !== 1 ? 's' : '');
}
</script>
</body>
</html>
