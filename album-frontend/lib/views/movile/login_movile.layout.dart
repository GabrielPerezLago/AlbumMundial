
import 'package:album_frontend/router/album.router.dart';
import 'package:album_frontend/services/LoginService.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/inputs/app_input.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginMovileLayout extends StatefulWidget {

  final LoginService? service;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;


  LoginMovileLayout({
    this.service,
    required this.nameController,
    required this.emailController,
    required this.passwordController
  });

  @override
  State<LoginMovileLayout> createState() => _LoginMovileLayoutState();
}

class _LoginMovileLayoutState extends State<LoginMovileLayout> {
  late final service = widget.service;
  bool _isRegister = false;
  String _errorMsg = "";

  @override
  Widget build(BuildContext context) => Container(
    width: width(context) * 0.95,
    child: Column(
      spacing: height(context) * 0.1,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Title(color: Colors.white, child: Text(_isRegister ? 'Registrate' : 'Inicio de Session', style: TextStyle(fontSize: width(context) * 0.08, color: Colors.white))),
        Column(
          spacing: height(context) * 0.05,
          children: [
            if(_isRegister) AlbumInput(lblText: 'Nombre', controller: widget.nameController,),
            AlbumInput(lblText: 'Email', controller: widget.emailController,),
            AlbumInput(lblText: 'Contaseña', isPasswored: true, controller: widget.passwordController,),
            Text(_errorMsg, style: TextStyle(color: Colors.red),)
          ],
        ),
        Column(

          spacing: height(context) * 0.02,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (_isRegister) {
                    register();
                  } else {
                    login();
                  }
                },
                child: Text( _isRegister ? 'Registrarse' : 'Iniciar Sesion' )
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: Size(width(context) * 0.5, height(context) * 0.2),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.white
              ),
                onPressed: (){
                setState(() {
                  _isRegister = !_isRegister;
                });
                },
                child: Text(_isRegister ? 'Inicio de session' : 'Resgistrarse', style: TextStyle(color: Colors.black),))
          ],
        )
      ],
    ),
  );

  void login() async {
    try {

      bool res  = await service!.signin(widget.emailController.text, widget.passwordController.text);

      if (res) {
        router.go('/album');
      } else {
        setState(() {
          _errorMsg = "Error algun campo no es valido";
        });
      }


    } catch (ex) {
      print(ex.toString());
    }
  }

  void register() async {
    try {
      bool res  = await service!.signup(widget.nameController.text, widget.emailController.text, widget.passwordController.text);

      if (res) {

      } else {
        setState(() {
          _errorMsg = "Error algun campo no es valido";
        });
      }
    } catch (ex) {
      print(ex);
    }
  }
}