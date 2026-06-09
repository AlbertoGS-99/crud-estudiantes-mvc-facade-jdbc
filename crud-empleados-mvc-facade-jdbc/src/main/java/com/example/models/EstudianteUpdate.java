package com.example.models;

import java.time.LocalDate;
import java.util.Set;

public record EstudianteUpdate(
		int id,
		String nombre,
		String apellidos,
		String email,
		String telefono,
		LocalDate fechaNacimiento,
		int idCarrera,
		String nombreCarrera,
		boolean activo,
		LocalDate fechaRegistro,
		LocalDate fechaActualizacion) {}