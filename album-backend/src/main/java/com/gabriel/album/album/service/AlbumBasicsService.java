package com.gabriel.album.album.service;

import com.gabriel.album.album.models.UsuarioCarta;
import com.gabriel.album.auth.model.Usuario;
import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.model.CartaDTO;
import com.gabriel.album.carta.utils.CartaUtils;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class AlbumBasicsService {

    private static final CartaUtils UTILS = new CartaUtils();


    @Transactional
    public Response getCartasByUsuario(Long idUsuario) {
        Usuario usuario = Usuario.findById(idUsuario);

        if (usuario == null) return Response.status(Response.Status.NOT_FOUND).entity("El usuario no existe").build();

        List<UsuarioCarta> usuarioCartas = UsuarioCarta
                .find("usuario.id = ?1 and cantidad > 1" , usuario.getId())
                .list();

        List<Carta> cartas = usuarioCartas.stream()
                .map(UsuarioCarta::getCarta)
                .collect(Collectors.toList());


        List<CartaDTO> cartasDTO = usuarioCartas.stream()
                .map(uc -> new CartaDTO(uc.getCarta(), uc.cantidad))
                .collect(Collectors.toList());

        return Response.ok(cartasDTO).build();

    }




    @Transactional
    public Response getCatasUserNotUser(Long idUser) {
        List<Carta> cartas = Carta.listAll();

        Usuario usuario = Usuario.findById(idUser);

        if (usuario == null) return Response.status(404).entity("El usuario no existe").build();

        List<Long> idsTiene = UsuarioCarta
                .find("usuario.id = ?1" , usuario.getId())
                .list()
                .stream()
                .map(uscar -> ((UsuarioCarta) uscar).getCarta().getId())
                .collect(Collectors.toList());

        List<Carta> noTiene;
        if (idsTiene.isEmpty()) {
            noTiene = Carta.listAll();
        } else {
            noTiene = Carta.find("id not in ?1", idsTiene).list();
        }

        List<CartaDTO> cartasDto = UTILS.parseToCartaDTO(noTiene);
        return Response.ok(cartasDto).build();
    }
}
