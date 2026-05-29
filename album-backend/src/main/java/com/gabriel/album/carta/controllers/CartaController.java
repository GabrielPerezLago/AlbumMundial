package com.gabriel.album.carta.controllers;

import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.services.CartasService;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.Response;


@Path("/cartas")
public class CartaController {
    @Inject
    private CartasService service;

    @GET
    public Response getCartas() {
        return Response.ok(Carta.listAll()).build();
    }

    @GET
    @Path("/find")
    public Response findByEquipo(@QueryParam("equipo")  String equipo) {
        return service.getCartasByEquipo(equipo);
    }

    @GET
    @Path("/sobres")
    public Response getSobres() {
        return service.getSobres();
    }



}
