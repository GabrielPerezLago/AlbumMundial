
import 'package:album_frontend/widgets/album_scafold.widget.dart';
import 'package:album_frontend/widgets/cards/sobre.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLayoutDesktop extends StatefulWidget {
  Widget child;

  HomeLayoutDesktop({
    required this.child
});

  @override
  State<StatefulWidget> createState() => _HomeLayoutDesktop();

}

class _HomeLayoutDesktop extends State<HomeLayoutDesktop> {
  @override
  Widget build(BuildContext context) => AlbumScafold(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.child,
        Sobre()
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
            BottomNavigationBarItem(icon: Icon(Icons.list,), label: 'Album'),
            BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Cartas')
        ]
    ),
  );
}