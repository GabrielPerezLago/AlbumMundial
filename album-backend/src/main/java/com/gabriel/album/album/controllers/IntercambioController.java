package com.gabriel.album.album.controllers;

import com.gabriel.album.album.models.IntercambioDTO;
import com.gabriel.album.album.models.UsuarioCartaDTO;
import com.gabriel.album.album.service.IntercambioService;
import jakarta.inject.Inject;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

@Path("/album")
public class IntercambioController {
    @Inject
    private IntercambioService service;

    @POST
    @Path("/intercambio")
    public Response intercambio(IntercambioDTO params) {
        return service.intercabioCarta(params.idUser(), params.idCartaUsuario(), params.idCartaPedida());
    }

    @POST
    @Path("/save")
    public Response saveCartas(UsuarioCartaDTO params){
        return service.saveCartas(params);
    }




}
