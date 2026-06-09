package com.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Logger;

import com.example.models.Carrera;
import com.example.models.Estudiante;
import com.example.services.CarreraService;
import com.example.services.CarreraServiceImpl;
import com.example.services.EstudianteService;
import com.example.services.EstudianteServiceImpl;

@WebServlet("/AltaController")
public class AltaController extends HttpServlet {

	private static final Logger LOG = Logger.getLogger("AltaController");
	private static final long serialVersionUID = 1L;

	public AltaController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		CarreraService carreraService = new CarreraServiceImpl();
		List<Carrera> carreras = null;

		try {
			carreras = carreraService.getCarreras();
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("carreras", carreras);
		request.getRequestDispatcher("views/formularioAltaModificacion.jsp")
				.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));

		String nombre             = request.getParameter("nombre");
		String apellidos          = request.getParameter("apellidos");
		String email              = request.getParameter("email");
		String telefono           = request.getParameter("telefono") == null ?
				"" : request.getParameter("telefono");
		LocalDate fechaNacimiento = LocalDate.parse(request.getParameter("fechaNacimiento"));
		int id_carrera            = Integer.parseInt(request.getParameter("carrera"));
		boolean activo            = Boolean.parseBoolean(request.getParameter("activo"));
		LocalDate fechaRegistro   = idEstudiante == 0 ? LocalDate.now() :
				LocalDate.parse(request.getParameter("fechaRegistro"));
		LocalDate fechaActualizacion = LocalDate.now();

		Estudiante estudiante = Estudiante.builder()
				.id(idEstudiante)
				.nombre(nombre)
				.apellidos(apellidos)
				.email(email)
				.telefono(telefono)
				.fechaNacimiento(fechaNacimiento)
				.id_carrera(id_carrera)
				.activo(activo)
				.fechaRegistro(fechaRegistro)
				.fechaActualizacion(fechaActualizacion)
				.build();

		EstudianteService estudianteService = new EstudianteServiceImpl();

		if (idEstudiante == 0) {
			// Alta nueva
			try {
				estudianteService.altaEstudiante(estudiante);
			} catch (SQLException e) {