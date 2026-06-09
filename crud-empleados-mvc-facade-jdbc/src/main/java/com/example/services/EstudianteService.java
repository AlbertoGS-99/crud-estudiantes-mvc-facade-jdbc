package com.example.services;

import java.sql.SQLException;
import java.util.List;

import com.example.models.Detalle;
import com.example.models.Estudiante;

public interface EstudianteService {
	boolean isConnectionOk() throws Exception;
	List<Estudiante> getEstudiantes();
	void altaEstudiante(Estudiante estudiante) throws SQLException;
	Detalle detalles(int idEstudiante);
}