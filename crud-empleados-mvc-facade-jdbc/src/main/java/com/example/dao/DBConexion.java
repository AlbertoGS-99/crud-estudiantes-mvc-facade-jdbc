package com.example.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Logger;

import com.example.models.Estudiante;

public class DBConexion implements AutoCloseable {

    private static final Logger LOG = Logger.getLogger("DBConexion");

    private String user;
    private String password;
    private Connection connection;

    public DBConexion(String user, String password) {
        super();
        this.user = user;
        this.password = password;
    }

    // ✅ Ahora lanza SQLException en lugar de tragársela
    public Connection getConexion() throws ClassNotFoundException, SQLException {
        String urlConnection = "jdbc:mysql://localhost:3306/Universidad";

        Properties info = new Properties();
        info.put("user", this.user);
        info.put("password", this.password);

        Class.forName("com.mysql.cj.jdbc.Driver");
        this.connection = DriverManager.getConnection(urlConnection, info);
        LOG.info("Conexion establecida con la base de datos, exitosamente !!!!");

        return this.connection;
    }

    @Override
    public void close() throws Exception {
        if (this.connection != null && !this.connection.isClosed()) {
            this.connection.close();
            LOG.info("Conexion cerrada correctamente");
        }
    }

    // Recupera todos los estudiantes
    public ResultSet getEstudiantes(Connection connection) {
        ResultSet rs = null;
        String query = "SELECT * FROM Universidad.estudiantes";
        Statement stmt = null;

        try {
            stmt = connection.createStatement();
            rs = stmt.executeQuery(query);
        } catch (SQLException e) {
            LOG.severe("Error recuperando estudiantes: " + e.getMessage());
            e.printStackTrace();
        }

        return rs;
    }

    // Recupera todas las carreras
    public ResultSet getCarreras(Connection connection) {
        ResultSet rs = null;
        String query = "SELECT * FROM Universidad.carreras";
        Statement stmt = null;

        try {
            stmt = connection.createStatement();
            rs = stmt.executeQuery(query);
        } catch (SQLException e) {
            LOG.severe("Error recuperando carreras: " + e.getMessage());
            e.printStackTrace();
        }

        return rs;
    }

    // Inserta un nuevo estudiante
    public void altaEstudiante(Estudiante estudiante, Connection connection) throws SQLException {
        String query = "INSERT INTO `estudiantes` (`nombre`, `apellidos`, `email`,"
                + " `telefono`, `fecha_nacimiento`, `id_carrera`,"
                + " `activo`, `fecha_registro`, `fecha_actualizacion`)"
                + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            PreparedStatement stmt = connection.prepareStatement(query,
                    Statement.RETURN_GENERATED_KEYS);

            stmt.setString(1, estudiante.nombre());
            stmt.setString(2, estudiante.apellidos());
            stmt.setString(3, estudiante.email());
            stmt.setString(4, estudiante.telefono());
            stmt.setDate(5, Date.valueOf(estudiante.fechaNacimiento()));
            stmt.setInt(6, estudiante.id_carrera());
            stmt.setBoolean(7, estudiante.activo());
            stmt.setDate(8, Date.valueOf(estudiante.fechaRegistro()));
            stmt.setDate(9, Date.valueOf(estudiante.fechaActualizacion()));

            stmt.executeUpdate();
            connection.commit();
            LOG.info("Estudiante insertado correctamente");

        } catch (Exception e) {
            LOG.severe("Error insertando estudiante: " + e.getMessage());
            connection.rollback();
            LOG.info("Transaccion revertida");
        } finally {
            connection.setAutoCommit(true);
        }
    }

    // Recupera detalles: carrera, asignaturas y matriculas
    public ResultSet detallesEstudiante(int idEstudiante, Connection connection) {
        ResultSet rs = null;
        String query = "SELECT car.nombre nombreCarrera, asi.nombre nombreAsignatura,"
                + " mat.anio_academico anio_academico"
                + " FROM estudiantes est"
                + " LEFT JOIN carreras car ON est.id_carrera = car.id"
                + " LEFT JOIN matriculas mat ON est.id = mat.id_estudiante"
                + " LEFT JOIN asignaturas asi ON mat.id_asignatura = asi.id"
                + " WHERE est.id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            stmt.setInt(1, idEstudiante);
            rs = stmt.executeQuery();
        } catch (SQLException e) {
            LOG.severe("Error recuperando detalles del estudiante");
            e.printStackTrace();
        }

        return rs;
    }

    // Recupera toda la informacion del estudiante a actualizar
    public ResultSet getEstudianteById(int idEstudiante, Connection connection) {
        ResultSet rs = null;
        String query = "SELECT est.id idEstudiante,"
                + " est.nombre nombreEstudiante,"
                + " est.apellidos,"
                + " est.email,"
                + " est.telefono,"
                + " est.fecha_nacimiento,"
                + " est.id_carrera idCarrera,"
                + " car.nombre nombreCarrera,"
                + " est.activo,"
                + " est.fecha_registro,"
                + " est.fecha_actualizacion"
                + " FROM estudiantes est"
                + " LEFT JOIN carreras car ON est.id_carrera = car.id"
                + " WHERE est.id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            stmt.setInt(1, idEstudiante);
            rs = stmt.executeQuery();
        } catch (SQLException e) {
            LOG.severe("Error recuperando estudiante por id: " + e.getMessage());
            e.printStackTrace();
        }

        return rs;
    }

    // Actualiza un estudiante existente
    public void updateEstudiante(Estudiante estudiante, Connection connection) {
        String query = "UPDATE `estudiantes`"
                + " SET `nombre` = ?, `apellidos` = ?, `email` = ?,"
                + " `telefono` = ?, `fecha_nacimiento` = ?, `id_carrera` = ?,"
                + " `activo` = ?, `fecha_actualizacion` = ?"
                + " WHERE (`id` = ?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, estudiante.nombre());
            stmt.setString(2, estudiante.apellidos());
            stmt.setString(3, estudiante.email());
            stmt.setString(4, estudiante.telefono());
            stmt.setDate(5, Date.valueOf(estudiante.fechaNacimiento()));
            stmt.setInt(6, estudiante.id_carrera());
            stmt.setBoolean(7, estudiante.activo());
            stmt.setDate(8, Date.valueOf(estudiante.fechaActualizacion()));
            stmt.setInt(9, estudiante.id());  
            stmt.executeUpdate();            
            LOG.info("Estudiante actualizado correctamente");
        } catch (SQLException e) {
            LOG.severe("Error actualizando estudiante: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}