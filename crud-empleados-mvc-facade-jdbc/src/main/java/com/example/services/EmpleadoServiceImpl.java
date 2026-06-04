package com.example.services;

import java.math.BigDecimal;
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
import com.example.models.Empleado;
import com.example.models.Genero;

public class EmpleadoServiceImpl implements EmpleadoService {
	
	private static final Logger LOG = Logger.getLogger("EmpleadoServiceImpl");

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

	@Override
	public List<Empleado> getEmpleados() {
		
		List<Empleado> empleados = new ArrayList<Empleado>();
		
		try (DBConexion dbConexion = new DBConexion("root", "Temp2025");
				Connection connection = dbConexion.getConexion()) {
			
			ResultSet rs = dbConexion.getEmpleados(connection);
		
			while (rs.next()) {
				
				empleados.add(
						Empleado.builder()
						.id(rs.getInt("id"))
						.nombre(rs.getString("nombre"))
						.primerApellido(rs.getString("primerApellido"))
						.segundoApellido(rs.getString("segundoApellido"))
						.fechaAlta(rs.getDate("fechaAlta").toLocalDate())
						.genero(Genero.valueOf(rs.getString("genero")))
						.salario(new BigDecimal(rs.getDouble("salario")))
						.departamentos_id(rs.getInt("departamentos_id"))
						.build()
						);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		return empleados;
	}

	@Override
	public void altaEmpleado(Empleado empleado, 
			List<String> emails, List<String> nTelefonos) throws SQLException {
		
		try (DBConexion dbConexion = new DBConexion("root", "Temp2025");
				Connection connection = dbConexion.getConexion()) {
			dbConexion.altaEmpleado(empleado, emails, nTelefonos, connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Detalle detalles(int idEmpleado) {
		
		Detalle detalles = null;
		
		try (DBConexion dbConexion = new DBConexion("root", "Temp2025");
				Connection connection = dbConexion.getConexion()) {
			
			ResultSet rs = dbConexion.detallesEmpleado(idEmpleado, connection);
			
			// Para recuperar el nombre del Dpto
			String nombreDpto = null;
			
			if (rs.next())
				nombreDpto = rs.getString("nombreDpto");
			
			// Para recuperar la lista de numeros de Telefono
			Set<String> numerosTelefono = new HashSet<String>();
		
			rs.beforeFirst();
			
			while (rs.next()) {
				numerosTelefono.add(rs.getString("numeroTelefono"));
			}
			
			
			// Para recuperar la lista de direcciones de correos
			Set<String> emails = new HashSet<String>();
			
			rs.beforeFirst();
			
			while (rs.next()) {
				emails.add(rs.getString("email"));
			}
			
			detalles = new Detalle(nombreDpto,
					numerosTelefono, 
					emails);
			
			// Mostrar el record detalles en la consola
			LOG.info("Detalle recuperado: " + detalles);
			
			
		} catch (Exception e) {
			LOG.severe("Error recuperando detalles en la capa de servicios");
		}
		
		return detalles;
	}

}












