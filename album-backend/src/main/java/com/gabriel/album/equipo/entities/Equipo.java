package com.gabriel.album.equipo.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gabriel.album.carta.model.Carta;
import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import java.util.List;

@Entity
@Table(name = "equipo", schema = "album")
public class Equipo extends PanacheEntity {

    private String nombre;
    private String continente;


    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getContinente() {
        return continente;
    }

    public void setContinente(String pais) {
        this.continente = pais;
    }

    @Override
    public String toString() {
        return "Equipo -> { ID =" + id + "; " + nombre + "; " + continente + "; }" ;
    }



    @OneToMany(mappedBy = "equipo")
    @JsonIgnore
    public List<Carta> cartas;

}
