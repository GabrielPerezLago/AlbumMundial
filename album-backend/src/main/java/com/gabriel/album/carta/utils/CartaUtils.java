package com.gabriel.album.carta.utils;

import com.gabriel.album.carta.model.Carta;
import com.gabriel.album.carta.model.CartaDTO;

import java.util.List;
import java.util.stream.Collectors;

public class CartaUtils {

    public Carta getRandomCarta(List<Carta> cartas) {
        int position = (int) (Math.random() * cartas.size());
        return cartas.get(position);
    }

    public CartaDTO getRandomCartaDTO(List<CartaDTO> cartas) {
        int position = (int) (Math.random() * cartas.size());
        return cartas.get(position);
    }

    public List<CartaDTO> parseToCartaDTO(List<Carta> cartas) {
        return cartas.stream()
                .map(CartaDTO::new)
                .collect(Collectors.toList());
    }

}
