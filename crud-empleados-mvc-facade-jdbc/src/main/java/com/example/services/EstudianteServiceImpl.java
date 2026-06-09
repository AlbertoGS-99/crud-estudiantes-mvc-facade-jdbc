package com.example.services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.dao.DBConexion;
import com.example.models.Estudiante;

public class EstudianteServiceImpl implements EstudianteService {

	@Override
	public boolean isConnectionOk() throws Exception {

		boolean connectionOk = false;

		try (DBConexion dbConexion = new DBConexion("root", "Temp2025");
		     Connection connection = dbConexion.getConexion()) {

			if (connection != null)
				connectionOk = true;

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		return connectionOk;
	}

	@Override
	public List<Estudiante> getEstudiantes() {

		List<Estudiante> estudiantes = new ArrayList<>();

		try (DBConexion dbConexion = new DBConexion("root", "Temp2025");
		     Connection connection = dbConexion.getConexion()) {

			ResultSet rs = dbConexion.getEstudiantes(connection);

			while (rs.next()) {

				estudiantes.add(
						Estudiante.builder()
								.id(rs.getInt("id"))
								.nombre(rs.getString("nombre"))
								.apellidos(rs.getString("apellidos"))
								.email(rs.getString("email"))
								.telefono(rs.getString("telefono"))
								.fechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate())
								.id_carrera(rs.getInt("id_carrera"))
								.activo(rs.getBoolean("activo"))
								.fechaRegistro(rs.getDate("fecha_registro").toLocalDate())
								.fechaActualizacion(rs.getDate("fecha_actualizacion").toLocalDate())
								.build()
				);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return estudiantes;
	}
}