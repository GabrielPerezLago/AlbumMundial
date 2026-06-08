package com.gabriel.album.album.models;

import java.util.Map;

public record UsuarioCartaDTO(
        Long idUsuario,
        Map<Long, Integer> cartaCantidad
) {
}
