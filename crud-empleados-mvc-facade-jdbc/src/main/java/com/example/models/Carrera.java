package com.example.models;

import lombok.Builder;

@Builder
public record Carrera(int id, String nombre, int creditos, int id_facultad) {}