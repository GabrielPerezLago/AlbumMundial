package com.gabriel.album.auth.model;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

@Entity
@Table(name="usuario", schema="album")
public class Usuario extends PanacheEntityBase {



    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public Long id;


    private String nombre;
    private String email;
    private String password;

    public Usuario() {}

    public Usuario(String nombre, String email, String password) {
        this.nombre = nombre;
        this.email = email;
        this.password = password;
    }


    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Usuario{ Id: " + id + "; nombre=" + nombre + ", email=" + email + ", password=" + password + '}';
    }
}
