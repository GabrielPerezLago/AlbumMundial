package com.gabriel.album.carta.services;

import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.model.CartaDTO;
import com.gabriel.album.carta.utils.CartaUtils;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

@ApplicationScoped
public class CartasService {
    private CartaUtils utils = new CartaUtils();


    @Transactional
    public Response getCartas() {
        List<Carta> cartas = Carta.listAll();
        List<CartaDTO> cartasDTO = utils.parseToCartaDTO(cartas);
        return Response.ok(cartasDTO).build();
    }

    @Transactional
    public Response getCartasByEquipo(String nombreEquipo) {
        List<Carta> cartas = Carta.list("equipo.nombre", nombreEquipo.toLowerCase());

        if (cartas == null) {
            return Response.status(Response.Status.NOT_FOUND).entity("Cartas").entity("El equipo no tiene cartas").build();
        }

        List<CartaDTO> cartasDTO = utils.parseToCartaDTO(cartas);


        return Response.ok(cartasDTO).build();
    }

    /**
     * Metodo que implementa una ThreadPool para generar los sobres de cartas
     * @return <Cartas> Sobres: List >> Cartas </Cartas>
     */
    @Transactional
    public Response getSobres() {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        List<Carta> cartas = Carta.listAll();
        List<CartaDTO> cartasDTO = utils.parseToCartaDTO(cartas);

        List<List<CartaDTO>> sobres = new ArrayList<>();

        for (int  i = 0; i <= 5; i++) {
            List<CartaDTO> sobre = new ArrayList<>();
            executor.execute(new SobresThreadManager(cartasDTO, sobre, 7));
            sobres.add(sobre);
        }

        return Response.ok(sobres).build();
    }






}
