package com.gabriel.album.carta.model;

import java.util.Date;

public record CartaEquipoDTO(
        Long id,
        String nombre,
        Double peso,
        Double altura,
        Date nacimiento,
        String equipo,
        Integer cantidad,
        boolean tieneCarta
) {
}
