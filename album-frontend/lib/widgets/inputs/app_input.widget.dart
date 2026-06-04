import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:flutter/material.dart';

class AlbumInput extends StatefulWidget {
  final TextEditingController? controller;
  String? lblText;
  bool isPasswored;

  AlbumInput({
    this.controller,
    this.lblText,
    this.isPasswored = false,
  });



  @override
  State<StatefulWidget> createState() => _AlbumInput();
}

class _AlbumInput extends State<AlbumInput> {

  bool _hidden = false;



  @override
  void initState() {
    if (widget.isPasswored) {
      setState(() {
        _hidden = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: widget.controller,
    obscureText: _hidden,
      autocorrect: true,
      style: TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
          labelText: widget.lblText,
          suffixIcon: widget.isPasswored ? IconButton(onPressed: () {
            setState(() {
              _hidden = !_hidden;
            });
          }, icon: Icon(_hidden ? Icons.visibility: Icons.visibility_off)) : null ,
          labelStyle: TextStyle(
            color: Colors.white54
          ) ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width(context) * 0.1),
            borderSide: BorderSide(
              color: Colors.green,
              width: 3,
            )
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width(context) * 0.1),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2
            )
          )
      )
  );

}