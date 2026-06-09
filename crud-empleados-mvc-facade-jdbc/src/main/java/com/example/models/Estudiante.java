package com.example.models;

import java.time.LocalDate;
import lombok.Builder;

@Builder
public record Estudiante(
		int id,
		String nombre,
		String apellidos,
		String email,
		String telefono,
		LocalDate fechaNacimiento,
		int id_carrera,
		boolean activo,
		LocalDate fechaRegistro,
		LocalDate fechaActualizacion) {}