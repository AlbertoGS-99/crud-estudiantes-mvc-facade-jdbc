package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;

public class DBConexion {
	
	private static final Logger LOG = Logger.getLogger("DBConexion");
	
	private String user;
	private String password;
	private Connection connection;
	
	public DBConexion(String user, String password) {
		super();
		this.user = user;
		this.password = password;
	}
	
	// Metodo que estable la conexion con la base de datos
	public Connection getConexion() throws ClassNotFoundException {
		
		String urlConnection = "jdbc:mysql://localhost:3306/empresa-crud-empleados-mostoles-backend";
		
		Properties info = new Properties();
		
		info.put("user", this.user);
		info.put("password", this.password);
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.connection = DriverManager.getConnection(urlConnection, info);
			LOG.info("Conexion establecida con la base de datos, exitosamente !!!!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return this.connection;
	}
}
