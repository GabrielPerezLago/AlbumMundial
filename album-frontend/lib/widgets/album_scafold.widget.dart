
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:flutter/material.dart';

class AlbumScafold extends Scaffold {
  final Widget? child;

  const AlbumScafold({
    super.appBar,
    this.child,
    super.bottomNavigationBar
  });


  @override
  // TODO: implement body
  Widget? get body => Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/img/album_mv_bg.png'), fit: BoxFit.contain, opacity: 0.8),
    ),
    child: child,
  );

}