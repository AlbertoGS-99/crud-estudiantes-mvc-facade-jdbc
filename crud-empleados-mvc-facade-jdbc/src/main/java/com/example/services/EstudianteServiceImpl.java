package com.example.services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

import com.example.dao.DBConexion;
import com.example.models.Detalle;
import com.example.models.Estudiante;
import com.example.models.EstudianteUpdate;

public class EstudianteServiceImpl implements EstudianteService {

    private static final Logger LOG = Logger.getLogger("EstudianteServiceImpl");

    @Override
    public boolean isConnectionOk() throws Exception {

       boolean connectionOk = false;

       try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
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

       try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
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
          LOG.severe("Error recuperando estudiantes: " + e.getMessage());
       }

       return estudiantes;
    }

    @Override
    public void altaEstudiante(Estudiante estudiante) throws SQLException {

       try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
            Connection connection = dbConexion.getConexion()) {

          dbConexion.altaEstudiante(estudiante, connection);

       } catch (Exception e) {
          e.printStackTrace();
       }
    }

    @Override
    public Detalle detalles(int idEstudiante) {

       Detalle detalles = null;

       try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
            Connection connection = dbConexion.getConexion()) {

          ResultSet rs = dbConexion.detallesEstudiante(idEstudiante, connection);

          String nombreCarrera = null;

          if (rs.next())
             nombreCarrera = rs.getString("nombreCarrera");

          Set<String> asignaturas = new HashSet<>();
          rs.beforeFirst();
          while (rs.next()) {
             asignaturas.add(rs.getString("nombreAsignatura"));
          }

          Set<String> matriculas = new HashSet<>();
          rs.beforeFirst();
          while (rs.next()) {
             matriculas.add(rs.getString("anio_academico"));
          }

          detalles = new Detalle(nombreCarrera, asignaturas, matriculas);
          LOG.info("Detalle recuperado: " + detalles);

       } catch (Exception e) {
          LOG.severe("Error recuperando detalles: " + e.getMessage());
       }

       return detalles;
    }

    @Override
    public EstudianteUpdate getEstudianteById(int idEstudiante) {

       EstudianteUpdate estudianteUpdate = null;

       try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
            Connection connection = dbConexion.getConexion()) {

          ResultSet rs = dbConexion.getEstudianteById(idEstudiante, connection);

          if (rs.next()) {
             estudianteUpdate = new EstudianteUpdate(
                   rs.getInt("idEstudiante"),
                   rs.getString("nombreEstudiante"),
                   rs.getString("apellidos"),
                   rs.getString("email"),
                   rs.getString("telefono"),
                   rs.getDate("fecha_nacimiento").toLocalDate(),
                   rs.getInt("idCarrera"),
                   rs.getString("nombreCarrera"),
                   rs.getBoolean("activo"),
                   rs.getDate("fecha_registro").toLocalDate(),
                   rs.getDate("fecha_actualizacion").toLocalDate()
             );
          }

       } catch (Exception e) {
          LOG.severe("Error recuperando estudiante por id: " + e.getMessage());
          e.printStackTrace();
       }

       return estudianteUpdate;
    }

    @Override
    public void updateEstudiante(Estudiante estudiante) {

       try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
            Connection connection = dbConexion.getConexion()) {

          dbConexion.updateEstudiante(estudiante, connection);

       } catch (Exception e) {
          LOG.severe("Error actualizando estudiante: " + e.getMessage());
          e.printStackTrace();
       }
    }
}