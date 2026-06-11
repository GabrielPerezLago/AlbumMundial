package com.gabriel.album.auth.service;

import com.gabriel.album.auth.model.Usuario;
import com.gabriel.album.auth.model.UsuarioResDTO;
import com.gabriel.album.auth.utils.AuthUtils;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.Response;
import org.mindrot.jbcrypt.BCrypt;

@ApplicationScoped
public class AuthService {
    private AuthUtils utils = new AuthUtils();

    @Transactional
    public Response signup(Usuario user) {

        if (!utils.validateUser(user)) return Response.status(Response.Status.UNAUTHORIZED).entity("Los parametros no son validos o vienen vacíos").build();

        Usuario exist = Usuario.find("email = ?1",  user.getEmail()).firstResult();

        if  (exist != null) return Response.status(404).entity("El usuario ya existe").build();

        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));

        user.persist();

        return Response
                .ok(new UsuarioResDTO(user.id, user.getNombre(), user.getEmail()))
                .build();
    }



    @Transactional
    public Response signin(String email,  String password) {

        if (!utils.validateEmail(email) || !utils.validatePassword(password)) return Response.status(Response.Status.UNAUTHORIZED).entity("El email o la contraseña no es validos").build();


        Usuario user = Usuario.find("email", email).firstResult();

        if (user == null) return Response.status(404).entity("Usuario no encontrado").build();

        boolean contrasena = BCrypt.checkpw(password, user.getPassword());

        if (!contrasena) return Response.status(404).entity("La contraseña no es correcta").build();

        return Response
                .ok(new UsuarioResDTO(user.id, user.getNombre(), user.getEmail()))
                .build();
    }


}
