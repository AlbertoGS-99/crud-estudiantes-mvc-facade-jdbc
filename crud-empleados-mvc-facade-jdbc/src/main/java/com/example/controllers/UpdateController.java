package com.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.example.models.Carrera;
import com.example.models.EstudianteUpdate;
import com.example.services.CarreraService;
import com.example.services.CarreraServiceImpl;
import com.example.services.EstudianteService;
import com.example.services.EstudianteServiceImpl;

@WebServlet("/UpdateController")
public class UpdateController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public UpdateController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));

		EstudianteService estudianteService = new EstudianteServiceImpl();

		EstudianteUpdate estudianteUpdate = estudianteService.getEstudianteById(idEstudiante);
		request.setAttribute("estudianteUpdate", estudianteUpdate);

		CarreraService carreraService = new CarreraServiceImpl();

		try {
			List<Carrera> carreras = carreraService.getCarreras();
			request.setAttribute("carreras", carreras);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.getRequestDispatcher("views/formularioAltaModificacion.jsp")
				.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}