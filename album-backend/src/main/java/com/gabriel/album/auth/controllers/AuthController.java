package com.gabriel.album.auth.controllers;

import com.gabriel.album.auth.model.Usuario;
import com.gabriel.album.auth.model.UsuarioDTO;
import com.gabriel.album.auth.service.AuthService;
import jakarta.inject.Inject;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

@Path("/auth")
public class AuthController {
    @Inject
    private AuthService service;


    @POST
    @Path("/signup")
    public Response signup(UsuarioDTO request) {
        return service.signup(new Usuario(request.nombre(), request.email(), request.password()));
    }

    @POST
    @Path("/signin")
    public Response signin(UsuarioDTO request) {
        return service.signin(request.email(), request.password());
    }
}
