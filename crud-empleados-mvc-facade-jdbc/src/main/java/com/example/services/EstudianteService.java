package com.example.services;

import java.sql.SQLException;

import java.util.List;

import com.example.models.Detalle;
import com.example.models.Estudiante;
import com.example.models.EstudianteUpdate;

public interface EstudianteService {
	boolean isConnectionOk() throws Exception;
	List<Estudiante> getEstudiantes();
	void altaEstudiante(Estudiante estudiante) throws SQLException;
	Detalle detalles(int idEstudiante);
	EstudianteUpdate getEstudianteById(int idEstudiante);
	void updateEstudiante(Estudiante estudiante);
}