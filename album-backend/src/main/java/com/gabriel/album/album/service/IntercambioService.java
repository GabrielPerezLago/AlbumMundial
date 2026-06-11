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
import java.util.Map;

@ApplicationScoped
public class IntercambioService {

    @Transactional
    public Response intercabioCarta(Long idUser, Long idCartaOfrecida, Long idCataCambio) {
        /// Validadcion de ususario
        Usuario usuario = Usuario.findById(idUser);
        if (usuario == null) return  Response.status(404).entity("El ususario no existe").build();

        ///  VAlidacion de CartaOfrecida
        Carta cartaOfrecida = Carta.findById(idCartaOfrecida);
        if (cartaOfrecida == null) return  Response.status(404).entity("La carta ofrecida no existe").build();

        ///  Esto busca si de vrd tenoa la carta que va a ofrecida
        UsuarioCarta cartaUsuarioOfrecida = UsuarioCarta
                .find("usuario.id = ?1 and carta.id = ?2", idUser, idCartaOfrecida)
                .firstResult();

        if (cartaUsuarioOfrecida == null || cartaUsuarioOfrecida.cantidad <=  1) {
            return Response.status(404).entity("El usuario con "+ idUser + "no tinene esa carta, o no la tinen repetida").build();
        }


        /// Comprobacion de la existencia de la cata solicitada
        Carta cartaSolicitada = Carta.findById(idCataCambio);
        if (cartaSolicitada == null) return Response.status(404).entity("Error: La carta solicitada no existe").build();

        ///  Comporbacion si tiene la carta solicitada

       UsuarioCarta exist = UsuarioCarta
               .find("usuario.id = ?1 and carta.id = ?2", usuario.id, idCataCambio)
               .firstResult();



       if (exist == null) {
           new UsuarioCarta(usuario, cartaSolicitada, 1).persist();
       }

        cartaUsuarioOfrecida.cantidad--;

       return Response.ok().entity("Intercambio Realizado con exito").build();
    }



    @Transactional
    public Response saveCartas(UsuarioCartaDTO req) {
        Usuario usuario = Usuario.findById(req.idUsuario());

        if (usuario == null) {
            return Response.status(404).entity("El usuario no existe").build();
        }

        for (Map.Entry<Long, Integer> entry: req.cartaCantidad().entrySet()) {
            Long idCarta = entry.getKey();
            Integer cantidad = entry.getValue();

            /// Comprebo que la carta esiota
            Carta carta =  Carta.findById(idCarta);
            if (carta == null) return  Response.status(404).entity("La carta no existe").build();


            int updated = UsuarioCarta
                    .update("cantidad = cantidad + ?1 where usuario.id = ?2 and carta.id = ?3",
                            cantidad, usuario.getId(), idCarta);

            if (updated == 0) {
                new UsuarioCarta(usuario, carta, cantidad).persist();
            }
        }



        return Response.ok().entity("Cartas Añadidas con exito").build();
    }



}
