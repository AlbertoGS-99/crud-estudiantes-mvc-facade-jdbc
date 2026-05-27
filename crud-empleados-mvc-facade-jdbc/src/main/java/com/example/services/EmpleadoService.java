package com.example.services;

import java.sql.SQLException;

public interface EmpleadoService {
	public abstract boolean isConnectionOk() throws SQLException, Exception ;
}
