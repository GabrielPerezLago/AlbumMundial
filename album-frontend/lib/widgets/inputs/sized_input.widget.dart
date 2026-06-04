
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/inputs/app_input.widget.dart';
import 'package:flutter/cupertino.dart';

class SizedAlbumInput extends StatelessWidget {
  double porcent;
  TextEditingController? controller;
  String? lblText;
  bool ispasswored;

  SizedAlbumInput({
    this.porcent = 0.03,
    this.controller,
    this.lblText,
    this.ispasswored = false
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width(context) * porcent,
    child: AlbumInput(
      controller: controller,
      lblText: lblText,
      isPasswored: ispasswored,
    ),
  );

}