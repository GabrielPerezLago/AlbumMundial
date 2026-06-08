package com.gabriel.album.album.controllers;

import com.gabriel.album.album.service.AlbumBasicsService;
import jakarta.inject.Inject;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;

@Path("/album-basics")
public class AlbumBasicsController {
    @Inject
    private AlbumBasicsService service;

    @POST
    @Path("/cartas-usuario/{idUsuario}")
    public Response getUsuarioCartas(@PathParam("idUsuario") Long idUsuario) {
        return service.getCartasByUsuario(idUsuario);
    }

    @POST
    @Path("/cartas-no-usuario/{idUsuario}")
    public Response getNoUsuarioCartas(@PathParam("idUsuario") Long idUsuario) {
        return service.getCatasUserNotUser(idUsuario);
    }
}
