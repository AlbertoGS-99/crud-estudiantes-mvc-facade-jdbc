package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import com.example.models.Empleado;

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

	@Override
	public void close() throws Exception {
		this.connection.close();
	}
	
	// Metodo que recupera todos los registros de la tabla empleados
	public ResultSet getEmpleados(Connection connection) {
		
		ResultSet rs = null;
		String query = "SELECT * FROM `empresa-crud-empleados-mostoles-backend`.empleados";
		Statement stmt = null;
		
		try {
			stmt = connection.createStatement();
			rs = stmt.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
		return rs;
	}
	
	// Metodo que recupera todos los registros de la tabla departamentos
	public ResultSet getDptos(Connection connection) {
		
		ResultSet rs = null;
		String query = "SELECT * FROM `empresa-crud-empleados-mostoles-backend`.departamentos";
		Statement stmt = null;
		
		try {
			stmt = connection.createStatement();
			rs = stmt.executeQuery(query);
		} catch (SQLException e) {
			LOG.severe("Error recuperando departamentos y la causa mas probable es: "
								+ e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}
	
	// Metodo que inserta empleado y sus correos y telefonos en la base de datos, 
	// en el marco de una transaccion
	public void altaEmpleado(Empleado empleado, List<String> dirCorreos, List<String> numerosTelefono) {
		
		// Inserta empleado y devuelve el last inserted id en la tabla de empleados
		String query1;
		
		// Con el id del empleado, tenemos que insertar sus corros y sus telefonos correspondientes
		// Inserta correos
		String query2;
		
		
		// Inserta telefonos
		String query3;
		
		
	}
}















