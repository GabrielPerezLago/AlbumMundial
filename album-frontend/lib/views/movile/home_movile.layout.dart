import 'package:album_frontend/widgets/album_scafold.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeMovile extends StatefulWidget {
  Widget child;

  HomeMovile({
    required this.child
  });


  @override
  State<StatefulWidget> createState() => _HomeMoviileState();

}

class _HomeMoviileState extends State<HomeMovile> {
  int page = 0;
  final pages = ['/album', '/inventory', '/change', '/sobres'];

  void paginate(int i) {
    setState(() => page = i);
    context.go(pages[i]);
  }

  @override
  Widget build(BuildContext context) => AlbumScafold(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      child: widget.child,
    ),
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: paginate,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.amp_stories,), label: 'Album'),
          BottomNavigationBarItem(icon: Icon(Icons.card_travel),label: 'Inventario'),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle), label: 'Intercambio'),
          BottomNavigationBarItem(icon: Icon(Icons.drafts), label: 'Sobres')
        ]
    ),
  );

}