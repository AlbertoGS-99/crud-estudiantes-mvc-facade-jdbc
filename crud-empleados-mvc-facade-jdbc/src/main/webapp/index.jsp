<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduNet — Gestión de Estudiantes</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

<!-- NAVBAR -->
<header class="navbar">
    <div class="navbar-left">
        <a href="index.jsp" class="logo">
            <svg width="26" height="26" viewBox="0 0 28 28" fill="none">
                <circle cx="14" cy="14" r="12" stroke="#00AAFF" stroke-width="2"/>
                <path d="M8 14 L14 8 L20 14 L14 20 Z" fill="#00AAFF"/>
                <circle cx="14" cy="14" r="3" fill="#fff"/>
            </svg>
            <span class="logo-text">Universidad</span>
        </a>
        <nav class="nav-links">
            <div class="nav-item"><a class="nav-btn" href="MainController">Estudiantes</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Carreras</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Asignaturas</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Matrículas</a></div>
            <div class="nav-item"><a class="nav-btn" href="#">Reportes</a></div>
        </nav>
    </div>
    <div class="navbar-right">
        <button class="nav-icon-btn">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
            <span>Buscar</span>
        </button>
        <button class="nav-icon-btn account-btn">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            <span>Administrador</span>
        </button>
    </div>
</header>

<div class="page-wrapper">

    <!-- HERO -->
    <div class="page-hero">
        <div class="page-hero-eyebrow">Panel de control</div>
        <h1>Gestión de Estudiantes</h1>
        <p>Accede al listado completo de estudiantes, consulta expedientes y administra la información académica desde un solo lugar.</p>
    </div>

    <!-- STATS BAR -->
    <div class="stats-bar">
        <div class="stat-item">
            <div class="stat-num">—</div>
            <div class="stat-label">Estudiantes</div>
        </div>
        <div class="stat-item">
            <div class="stat-num">—</div>
            <div class="stat-label">Carreras</div>
        </div>
        <div class="stat-item">
            <div class="stat-num">—</div>
            <div class="stat-label">Asignaturas</div>
        </div>
        <div class="stat-item">
            <div class="stat-num">—</div>
            <div class="stat-label">Activos</div>
        </div>
    </div>

    <!-- QUICK ACCESS -->
    <div class="content">
        <h2 class="section-title">Accesos rápidos</h2>
        <div class="quick-cards">
            <a href="MainController" class="quick-card">
                <div class="quick-card-icon">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                    </svg>
                </div>
                <h3>Listado de estudiantes</h3>
                <p>Consulta y filtra todos los estudiantes registrados en el sistema.</p>
                <span class="quick-card-arrow">Ver todos →</span>
            </a>
            <a href="#" class="quick-card">
                <div class="quick-card-icon">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/>
                    </svg>
                </div>
                <h3>Calendario académico</h3>
                <p>Consulta fechas importantes, exámenes y períodos de matrícula.</p>
                <span class="quick-card-arrow">Ver calendario →</span>
            </a>
            <a href="#" class="quick-card">
                <div class="quick-card-icon">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/>
                        <line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/>
                    </svg>
                </div>
                <h3>Reportes</h3>
                <p>Genera informes académicos y estadísticas del sistema.</p>
                <span class="quick-card-arrow">Ver reportes →</span>
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
