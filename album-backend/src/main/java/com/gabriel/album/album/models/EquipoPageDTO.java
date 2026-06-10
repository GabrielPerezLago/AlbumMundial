package com.gabriel.album.album.models;

import com.gabriel.album.carta.model.CartaEquipoDTO;

import java.util.List;

public record EquipoPageDTO(
        String equipoNombre,
        List<CartaEquipoDTO> cartas,
        Long beforeEquipo,
        Long afterEquipo
) {
}
