package com.example.services;

import java.sql.Connection;
import java.sql.SQLException;

import com.example.dao.DBConexion;

public class EmpleadoServiceImpl implements EmpleadoService {

	@Override
	public boolean isConnectionOk() throws SQLException {
		
		DBConexion dbConexion = new DBConexion("root", "Temp2025");
		
		boolean connectionOk = false;
		Connection connection = null;
		
		try {
			connection = dbConexion.getConexion();
			if (connection != null) 
				connectionOk = true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (connection != null)
				connection.close();
		}
		
		return connectionOk;
	}

}
