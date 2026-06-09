package com.example.models;

import java.util.Set;

public record Detalle(String nombreCarrera, Set<String> asignaturas, Set<String> matriculas) {}