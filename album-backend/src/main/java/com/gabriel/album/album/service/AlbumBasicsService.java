package com.gabriel.album.album.service;

import com.gabriel.album.album.models.EquipoPageDTO;
import com.gabriel.album.album.models.UsuarioCarta;
import com.gabriel.album.auth.model.Usuario;
import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.model.CartaDTO;
import com.gabriel.album.carta.model.CartaEquipoDTO;
import com.gabriel.album.carta.utils.CartaUtils;
import com.gabriel.album.equipo.entities.Equipo;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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


        List<CartaDTO> cartasDTO = usuarioCartas.stream()
                .map(uc -> new CartaDTO(uc.getCarta(), uc.cantidad))
                .collect(Collectors.toList());

        return Response.ok(cartasDTO).build();

    }




    @Transactional
    public Response getCatasUserNotUser(Long idUser) {

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

    @Transactional
    public Response getAlbumPage(Long idUsuario, Long equipoId) {
        Usuario usuario = Usuario.findById(idUsuario);
        if (usuario == null) return Response.status(404).entity("El usuario no existe").build();

        Equipo equipo = Equipo.findById(equipoId);
        if (equipo == null) return Response.status(404).entity("Equipo no existe").build();

        List<Carta> cartas = Carta.find("equipo.id = ?1", equipoId).list();

        List<UsuarioCarta> listaUsuarioCartas = UsuarioCarta
                .find("usuario.id = ?1 and carta.equipo.id = ?2", idUsuario, equipoId)
                .list();

        Map<Long, UsuarioCarta> usuarioCartas = listaUsuarioCartas.stream()
                .collect(Collectors.toMap(
                        uc -> uc.getCarta().getId(),
                        uc -> uc
                ));


        List<CartaEquipoDTO> cartasEquipoDTO = cartas.stream().map( carta ->  {
            UsuarioCarta usuarioCarta = usuarioCartas.get(carta.getId());
            return new CartaEquipoDTO(
                    carta.getId(),
                    carta.getNombre(),
                    carta.getPeso(),
                    carta.getAltura(),
                    carta.getNacimiento(),
                    equipo.getNombre(),
                    usuarioCarta != null ? usuarioCarta.cantidad : 0,
                    usuarioCarta != null
            );
        }).collect(Collectors.toList());

        Equipo prevEquipo = Equipo.find("id < ?1 order by id desc", equipoId).firstResult();
        Equipo nextEquipo = Equipo.find("id > ?1 order by id asc", equipoId).firstResult();

        return Response.ok(new EquipoPageDTO(
                equipo.getNombre(),
                cartasEquipoDTO,
                prevEquipo != null ? prevEquipo.getId() : null,
                nextEquipo != null ? nextEquipo.getId() : null
        )).build();
    }
}
