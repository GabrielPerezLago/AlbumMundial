import 'dart:typed_data';

import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/Containers/desk_container.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginDesktop extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginDesktopState();

}


class _LoginDesktopState extends State<LoginDesktop> {


  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    child: _loginRow()
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
      )
    ],
  );
}