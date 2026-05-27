package com.example.services;

import java.sql.Connection;

import com.example.dao.DBConexion;

public class EmpleadoServiceImpl implements EmpleadoService {

	@Override
	public boolean isConnectionOk() throws Exception {
		
		
		
		boolean connectionOk = false;
		
		
		try (DBConexion dbConexion = new DBConexion("root", "Temp2025");
			  Connection connection = dbConexion.getConexion())  {
			
			if (connection != null) 
				connectionOk = true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return connectionOk;
	}

}
