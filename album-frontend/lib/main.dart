import 'package:album_frontend/router/album.router.dart';
import 'package:album_frontend/themes/AlbumTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AlbumMundial());
}

class AlbumMundial extends StatelessWidget {
  const AlbumMundial({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AlbumTheme.LIGHT,
      darkTheme: AlbumTheme.DARK,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}