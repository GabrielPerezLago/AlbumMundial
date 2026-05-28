package com.gabriel.album.auth.utils;

import com.gabriel.album.auth.model.Usuario;

public class AuthUtils {

    public boolean validateEmail(String email) {
        return  email != null && email.contains("@") && email.contains(".") ;
    }

    public boolean validateUser(Usuario usuario) {
        if  (usuario == null) {
            return false;
        }

        if (usuario.getNombre() == null || usuario.getNombre().equals("")) {
            return false;
        }

        if (usuario.getEmail() == null || usuario.getEmail().equals("") || !validateEmail(usuario.getEmail())) {
            return false;
        }

        if (usuario.getPassword() == null || usuario.getPassword().equals("")) {
            return false;
        }

        return true;
    }


    public boolean validatePassword(String password) {
        return password != null && !password.equals("");
    }
}
