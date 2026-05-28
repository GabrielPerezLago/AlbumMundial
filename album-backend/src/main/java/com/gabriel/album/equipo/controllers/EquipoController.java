package com.gabriel.album.equipo.controllers;

import com.gabriel.album.equipo.entities.Equipo;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

import java.util.List;

@Path("/equipos")
public class EquipoController {
    @GET
    public List<Equipo> getEquipos() {
        return Equipo.listAll();
    }


}
