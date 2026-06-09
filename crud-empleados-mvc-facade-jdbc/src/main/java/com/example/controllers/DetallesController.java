package com.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import com.example.models.Detalle;
import com.example.models.Estudiante;
import com.example.services.EstudianteService;
import com.example.services.EstudianteServiceImpl;

@WebServlet("/DetallesController")
public class DetallesController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger("DetallesController");

	public DetallesController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));

		LOG.info("Id Estudiante recibido: " + idEstudiante);

		EstudianteService estudianteService = new EstudianteServiceImpl();

		List<Estudiante> estudiantes = estudianteService.getEstudiantes();

		Estudiante estudiante = estudiantes.stream()
				.filter(e -> e.id() == idEstudiante)
				.findFirst()
				.orElseThrow(() ->
						new RuntimeException("Estudiante no encontrado"));

		request.setAttribute("estudiante", estudiante);

		Detalle detalles = estudianteService.detalles(idEstudiante);
		request.setAttribute("detalles", detalles);

		request.getRequestDispatcher("views/detallesEstudiante.jsp")
				.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}