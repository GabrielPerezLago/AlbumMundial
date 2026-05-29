package com.gabriel.album.carta.utils;

import com.gabriel.album.carta.model.Carta;

import java.util.List;

public class CartaUtils {

    public Carta getRandomCarta(List<Carta> cartas) {
        int position = (int) (Math.random() * cartas.size());
        return cartas.get(position);
    }

}
