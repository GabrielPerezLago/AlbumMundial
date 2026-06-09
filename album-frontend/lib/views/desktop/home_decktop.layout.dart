
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/widgets/album_scafold.widget.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeLayoutDesktop extends StatefulWidget {
  Widget child;

  HomeLayoutDesktop({
    required this.child
});

  @override
  State<StatefulWidget> createState() => _HomeLayoutDesktop();

}

class _HomeLayoutDesktop extends State<HomeLayoutDesktop> {

  /// Todo: Manejador de pginas
  int _page = 0;
  final _pages = [ '/album', '/inventory', '/change'];

  void paginate (int i) {
    setState(() => _page = i);
    context.go(_pages[i]);
  }

  @override
  Widget build(BuildContext context) => AlbumScafold(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      child: widget.child,
    ),
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: paginate,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
            BottomNavigationBarItem(icon: Icon(Icons.amp_stories,), label: 'Album'),
            BottomNavigationBarItem(icon: Icon(Icons.card_travel),label: 'Inventario'),
            BottomNavigationBarItem(icon: Icon(Icons.change_circle), label: 'Intercambio')
        ]
    ),
  );
}