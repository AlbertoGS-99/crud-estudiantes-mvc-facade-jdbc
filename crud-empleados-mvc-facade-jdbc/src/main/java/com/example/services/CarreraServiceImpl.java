package com.example.services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import com.example.dao.DBConexion;
import com.example.models.Carrera;

public class CarreraServiceImpl implements CarreraService {

    private static final Logger LOG = Logger.getLogger("CarreraServiceImpl");

    @Override
    public List<Carrera> getCarreras() throws Exception {
        List<Carrera> carreras = new ArrayList<>();

        // ✅ try-with-resources cierra la conexión automáticamente
        try (DBConexion dbConexion = new DBConexion("root", "Temp2026");
             Connection connection = dbConexion.getConexion()) {  // ahora lanza si falla

            ResultSet rs = dbConexion.getCarreras(connection);
            while (rs.next()) {
                carreras.add(Carrera.builder()
                        .id(rs.getInt("id"))
                        .nombre(rs.getString("nombre"))
                        .creditos(rs.getInt("creditos"))
                        .id_facultad(rs.getInt("id_facultad"))
                        .build());
            }

        } catch (SQLException e) {
            LOG.severe("Error recuperando carreras: " + e.getMessage());
            e.printStackTrace();
            throw e; // ✅ relanza para que el Controller lo reciba y lo veas en logs
        }

        return carreras;
    }
}