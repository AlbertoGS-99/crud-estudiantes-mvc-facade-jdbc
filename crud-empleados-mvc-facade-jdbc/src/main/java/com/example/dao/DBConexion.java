package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Logger;

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

	// Metodo que establece la conexion con la base de datos
	public Connection getConexion() throws ClassNotFoundException {

		String urlConnection = "jdbc:mysql://localhost:3306/Universidad";  // ← cambiado

		Properties info = new Properties();

		info.put("user", this.user);
		info.put("password", this.password);

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.connection = DriverManager.getConnection(urlConnection, info);
			LOG.info("Conexion establecida con la base de datos, exitosamente !!!!");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return this.connection;
	}

	@Override
	public void close() throws Exception {
		this.connection.close();
	}

	// Metodo que recupera todos los registros de la tabla estudiantes  // ← cambiado
	public ResultSet getEstudiantes(Connection connection) {             // ← cambiado

		ResultSet rs = null;
		String query = "SELECT * FROM Universidad.estudiantes";          // ← cambiado
		Statement stmt = null;

		try {
			stmt = connection.createStatement();
			rs = stmt.executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}
}