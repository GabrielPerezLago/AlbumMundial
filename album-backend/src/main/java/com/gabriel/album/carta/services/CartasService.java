package com.gabriel.album.carta.services;

import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.utils.SobresThreadManager;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@ApplicationScoped
public class CartasService {

    @Transactional
    public Response getCartasByEquipo(String nombreEquipo) {
        List<Carta> cartas = Carta.list("equipo.nombre", nombreEquipo.toLowerCase());

        if (cartas == null) {
            return Response.status(Response.Status.NOT_FOUND).entity("Cartas").entity("El equipo no tiene cartas").build();
        }

        return Response.ok(cartas).build();
    }

    /**
     * Metodo que implementa una ThreadPool para generar los sobres de cartas
     * @return <Cartas> Sobres: List >> Cartas </Cartas>
     */
    @Transactional
    public Response getSobres() {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        List<Carta> cartas = Carta.listAll();

        List<List<Carta>> sobres = new ArrayList<>();

        for (int  i = 0; i <= 5; i++) {
            List<Carta> sobre = new ArrayList<>();
            executor.execute(new SobresThreadManager(cartas, sobre, 7));
            sobres.add(sobre);
        }


        return Response.ok(sobres).build();

    }




}
