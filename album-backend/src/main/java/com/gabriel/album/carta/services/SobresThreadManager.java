package com.gabriel.album.carta.services;

import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.model.CartaDTO;
import com.gabriel.album.carta.utils.CartaUtils;

import java.util.List;

public class SobresThreadManager implements Runnable {
    private static final CartaUtils UTILS = new CartaUtils();

    private List<CartaDTO> cartas;
    private List<CartaDTO> sobre;
    private int size;

    public SobresThreadManager(List<CartaDTO> cartas, List<CartaDTO> sobre, int size) {
        this.cartas = cartas;
        this.sobre = sobre;
        this.size = size;
    }

    @Override
    public void run() {
        for (int i = 0; i <= size; i++) {
            sobre.add(UTILS.getRandomCartaDTO(cartas));
        }
    }
}
