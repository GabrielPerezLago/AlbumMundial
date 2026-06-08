package com.gabriel.album.album.models;

import com.gabriel.album.auth.model.Usuario;
import com.gabriel.album.carta.model.Carta;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

@Entity
@Table(name="carta_usuario", schema = "album")
public class UsuarioCarta extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @ManyToOne
    @JoinColumn(name = "id_carta")
    private Carta carta;

    @ManyToOne
    @JoinColumn(name = "id_usuario")
    private Usuario usuario;


    public Integer cantidad;

    public UsuarioCarta() {}

    public UsuarioCarta(Usuario usuario, Carta carta, Integer cantidad) {
        this.usuario = usuario;
        this.carta = carta;
        this.cantidad = cantidad;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Carta getCarta() {
        return carta;
    }

    public void setCarta(Carta carta) {
        this.carta = carta;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }



}
