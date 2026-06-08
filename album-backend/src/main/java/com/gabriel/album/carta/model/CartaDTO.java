package com.gabriel.album.carta.model;

import java.util.Date;

public record CartaDTO(
        Long id,
        String nombre,
        Date nacimiento,
        Double peso,
        Double altura,
        String equipo
) {
    public CartaDTO(Carta carta) {
        this(
                carta.getId(),
                carta.getNombre(),
                carta.getNacimiento(),
                carta.getPeso(),
                carta.getAltura(),
                carta.equipo != null ? carta.equipo.getNombre() : null
        );
    }
}
