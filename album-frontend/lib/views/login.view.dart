import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/views/desktop/login_movile.layout.dart';
import 'package:album_frontend/widgets/album_scafold.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => AlbumScafold(
    child: isLoading ?
    Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeAlign: width(context) * 0.01,)
    ) : SafeArea(child: SingleChildScrollView(
      child: isDesktop ?

      //TODO: Vista de Escritorio
        Container(
            child: Text('Desktop')
        ) :

      // TODO: Vista de Movil
        LoginMovileLayout()
        ),
    ));
}