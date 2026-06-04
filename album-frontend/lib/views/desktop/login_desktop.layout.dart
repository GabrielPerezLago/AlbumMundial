import 'dart:math';
import 'dart:typed_data';

import 'package:album_frontend/router/album.router.dart';
import 'package:album_frontend/services/LoginService.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/uitls/UserUtils.dart';
import 'package:album_frontend/views/login.view.dart';
import 'package:album_frontend/widgets/Containers/desk_container.widget.dart';
import 'package:album_frontend/widgets/inputs/sized_input.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginDesktop extends StatefulWidget {
  late final LoginService service;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;


  LoginDesktop({
    required this.service,
    required this.nameController,
    required this.emailController,
    required this.passwordController
  });

  @override
  State<StatefulWidget> createState() => _LoginDesktopState();

}


class _LoginDesktopState extends State<LoginDesktop> {
    bool isLoading = false;

    static final utils = UserUtils();
    bool isRegister = false;
    String _errMsg = "";
  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    child: isLoading ?
    Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(strokeAlign: width(context) * 0.01,)
    ) :
    isRegister ? _registerRow() : _loginRow()
  );



  Row _loginRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      DesckContainer(
        color: Colors.white60,
        child: Image(
          image: AssetImage('assets/img/copa.png')
          ,),
      ),

      DesckContainer(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: height(context) * 0.03,
          children: [
            Text('Iniciar Sesión', style: TextStyle(fontSize: width(context) * 0.03),),
            SizedAlbumInput(
              controller: widget.emailController,
              porcent: 0.3,
              lblText: 'Email',
            ),
            SizedAlbumInput(
              controller: widget.passwordController,
              porcent: 0.3,
              lblText: 'Contraseña',
              ispasswored: true,
            ),
            if(_errMsg != "") Text(_errMsg, style: TextStyle(color: Colors.red),),
            ElevatedButton(
                onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      final validate = utils.checkData(widget.emailController.text, widget.passwordController.text);

                      if(!validate) setState(() {
                        _errMsg = "El email o la contraseña no son validos";
                      });

                      final response = await widget.service.signin(widget.emailController.text, widget.passwordController.text);

                      if (!response) {
                        setState(() {
                          isLoading= false;
                          _errMsg = "El email o la contraseña no son validos";
                        });
                      } else {
                        router.go('/album');
                      }
                    } catch (ex) {
                      print("Exception: $ex");
                    }
                },
                child: Text('Iniciar Sesión', style: TextStyle(fontSize: width(context) * 0.01),) ,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all((height(context)*width(context)) % 47)
                )
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.white,
                animationDuration: Duration(microseconds: 0)
              ),
                onPressed: () {
                  setState(() {
                    isRegister = !isRegister;
                  });
                } ,
                child: Text('Registrarse', style: TextStyle(color: Colors.black),))
          ],
        ),
      )
    ],
  );

  Row _registerRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      DesckContainer(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: height(context) * 0.03,
          children: [
            Text('Registrate', style: TextStyle(fontSize: width(context) * 0.03),),
            SizedAlbumInput(
              controller: widget.nameController,
              porcent: 0.3,
              lblText: 'Nombre',
            ),
            SizedAlbumInput(
              controller: widget.emailController,
              porcent: 0.3,
              lblText: 'Email',
            ),
            SizedAlbumInput(
              controller: widget.passwordController,
              porcent: 0.3,
              lblText: 'Contraseña',
              ispasswored: true,
            ),
            if(_errMsg != "") Text(_errMsg, style: TextStyle(color: Colors.red),),
            ElevatedButton(
                onPressed: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    final validate = utils.checkDataWhithName(widget.nameController.text, widget.emailController.text, widget.passwordController.text);
                    if (!validate) setState(() {
                      _errMsg = "El email o la contraseña no son validos";
                    });
                    final response = await widget.service.signup(widget.nameController.text, widget.emailController.text, widget.passwordController.text);

                    if (response) {
                      setState(() {
                        isLoading = false;
                        _errMsg = "El email o la contraseña no son validos";
                      });
                    } else {
                      router.go('/album');
                    }
                  } catch (ex) {
                    print("Exception: $ex");
                  }
                },
                child: Text('Registrarse', style: TextStyle(fontSize: width(context) * 0.01),) ,
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all((height(context)*width(context)) % 47)
                )
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.white,
                    animationDuration: Duration(microseconds: 0)
                ),
                onPressed: () {
                  setState(() {
                    isRegister = !isRegister;
                  });
                } ,
                child: Text('Iniciar Sesión', style: TextStyle(color: Colors.black),))
          ],
        ),
      ),
      DesckContainer(
        color: Colors.white60,
        child: Image(
          image: AssetImage('assets/img/copa.png')
          ,),
      ),
    ],
  );
}