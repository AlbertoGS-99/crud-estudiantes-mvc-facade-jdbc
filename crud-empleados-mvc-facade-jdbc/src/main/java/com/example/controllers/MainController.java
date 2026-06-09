package com.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import com.example.models.Estudiante;
import com.example.services.EstudianteService;
import com.example.services.EstudianteServiceImpl;

@WebServlet("/MainController")
public class MainController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger("MainController");

	public MainController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		EstudianteService estudianteService = new EstudianteServiceImpl();

		List<Estudiante> estudiantes = estudianteService.getEstudiantes();

		request.setAttribute("estudiantes", estudiantes);

		request.getRequestDispatcher("views/listadoEstudiantes.jsp")
				.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}