package com.gabriel.album.album.service;

import com.gabriel.album.album.models.UsuarioCarta;
import com.gabriel.album.album.models.UsuarioCartaDTO;
import com.gabriel.album.auth.model.Usuario;
import com.gabriel.album.carta.model.Carta;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.List;

@ApplicationScoped
public class IntercambioService {

    @Transactional
    public Response intercabioCarta(Long idUser, Long idCartaOfrecida, Long idCataCambio) {

        ///  Esto busca si de vrd tenoa la carta que va a cambiar
        UsuarioCarta cartaUsuario = UsuarioCarta
                .find("usuario.id = ?1 and carta.id = ?2", idUser, idCartaOfrecida)
                .firstResult();

        if (cartaUsuario == null || cartaUsuario.cantidad <=  1) {
            return Response.status(404).entity("El usuario con "+ idUser + "no tinene esa carta, o no la tinen repetida").build();
        }


        /// Comprobacion de la existencia de la cata solicitada
        Carta solicitedCarta = Carta.findById(idCataCambio);

        if (solicitedCarta == null) {
            return Response.status(404).entity("Error: La carta solicitada no existe").build();
        }

        ///  Comporbacion si tiene la carta solicitada

        UsuarioCarta haveCartaSolicitada = UsuarioCarta
                .find("usuario.id = ?1 and carta.id = ?2" , idUser, idCataCambio)
                .firstResult();

        if (haveCartaSolicitada != null && haveCartaSolicitada.cantidad >= 1) {
            return Response.status(404).entity("El usuario ya tiene la carta solicitada, no se pueden intercambiar por cartas que esten en possession").build();
        }


        cartaUsuario.cantidad--;

        ///  Insercion de la carta en la base de datos
        Usuario usuario = Usuario.findById(idUser);
        Carta carta = Carta.findById(idCataCambio);

        return innerOrCreateCartaToUser(
                new UsuarioCarta(usuario, carta, 1)
        );

    }

    @Transactional
    public Response innerOrCreateCartaToUser(UsuarioCarta usuarioCarta) {
        UsuarioCarta baraja = UsuarioCarta
                .find("usuario.id = ?1 and carta.id = ?2" , usuarioCarta.getUsuario().getId(), usuarioCarta.getCarta().getId())
                .firstResult();

        if (baraja == null) {
            usuarioCarta.persist();
            return Response.ok(usuarioCarta).build();
        } else {
            baraja.cantidad += usuarioCarta.cantidad;
            return Response.ok(baraja).build();
        }

    }


    @Transactional
    public Response saveCartas(UsuarioCartaDTO req) {
        Usuario usuario = Usuario.findById(req.idUsuario());

        if (usuario == null) {
            return Response.status(404).entity("El usuario no existe").build();
        }

        List<UsuarioCarta> CartasList = new ArrayList<>();
        req.cartaCantidad().forEach((carta, catidad) -> {
            CartasList.add(
                    new UsuarioCarta(
                            usuario,
                            Carta.findById(carta),
                            catidad
                    )
            );
        });


        if  (CartasList.isEmpty()) {
            Response.status(404).entity("Error con las cartas, puede que no existan , por favor compruebe los parametros ").build();
        }


        List<Response> responses = new ArrayList<>();

        for (UsuarioCarta carta : CartasList) {
            Response res = innerOrCreateCartaToUser(carta);
            responses.add(res);
        }

        for (Response res : responses) {
            if (res.getStatus() >= 400) {
                return res;
            }
        }

        return Response.ok().entity("Cartas Añadidas con exito").build();
    }



}
