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

@ApplicationScoped
public class AlbumBasicsService {

    private static final CartaUtils UTILS = new CartaUtils();


    @Transactional
    public Response getCartasByUsuario(Long idUsuario) {
        Usuario usuario = Usuario.findById(idUsuario);

        if (usuario == null) return Response.status(Response.Status.NOT_FOUND).entity("El usuario no existe").build();

        List<UsuarioCarta> usuarioCartas = UsuarioCarta
                .find("usuario.id = ?" , usuario.getId())
                .list();

        List<Carta> cartas = new ArrayList<>();

        for (UsuarioCarta usuarioCarta : usuarioCartas) {
            Carta carta = Carta.findById(usuarioCarta.getCarta().getId());

            if(carta == null) return Response.status(404).entity("Error la carta con id: " + usuarioCarta.getCarta().getId() + " no existe").build();

            cartas.add(carta);
        }

        List<CartaDTO> cartasDTO = UTILS.parseToCartaDTO(cartas);

        return Response.ok(cartasDTO).build();

    }




    @Transactional
    public Response getCatasUserNotUser(Long idUser) {
        List<Carta> cartas = Carta.listAll();

        Usuario usuario = Usuario.findById(idUser);

        if (usuario == null) return Response.status(404).entity("El usuario no existe").build();

        List<UsuarioCarta> usuarioCartas = UsuarioCarta
                .find("usuario.id = ?" , usuario.getId())
                .list();

        if(usuarioCartas == null) return Response.status(404).entity("El usuario aun no tiene cartas").build();

        List<Carta> noTiene = new ArrayList<>();
        for (int i = 0; i <= cartas.size(); i++) {
            Carta carta = cartas.get(i);
            UsuarioCarta usuarioCarta = usuarioCartas.get(i);

            if (!carta.getId().equals(usuarioCarta.getCarta().getId())) {
                noTiene.add(carta);
            }
        }

        List<CartaDTO> cartasDto = UTILS.parseToCartaDTO(noTiene);
        return Response.ok(cartasDto).build();
    }
}
