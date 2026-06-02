
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/inputs/app_input.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginMovileLayout extends StatefulWidget {
  @override
  State<LoginMovileLayout> createState() => _LoginMovileLayoutState();
}

class _LoginMovileLayoutState extends State<LoginMovileLayout> {

  bool _isRegister = false;

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
            if(_isRegister) AlbumInput(lblText: 'Nombre',),
            AlbumInput(lblText: 'Email'),
            AlbumInput(lblText: 'Contaseña', isPasswored: true,),
          ],
        ),
        Column(

          spacing: height(context) * 0.02,
          children: [
            ElevatedButton(
                onPressed: () {},
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
}