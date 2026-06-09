package com.example.services;

import java.util.List;
import com.example.models.Carrera;

public interface CarreraService {
    List<Carrera> getCarreras() throws Exception;
}