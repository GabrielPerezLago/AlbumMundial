package com.gabriel.album.carta.utils;

import com.gabriel.album.carta.model.Carta;

import java.util.List;

public class SobresThreadManager implements Runnable {
    private static final CartaUtils UTILS = new CartaUtils();

    private List<Carta> cartas;
    private List<Carta> sobre;
    private int size;

    public SobresThreadManager(List<Carta> cartas, List<Carta> sobre, int size) {
        this.cartas = cartas;
        this.sobre = sobre;
        this.size = size;
    }

    @Override
    public void run() {
        for (int i = 0; i <= size; i++) {
            sobre.add(UTILS.getRandomCarta(cartas));
        }
    }
}
