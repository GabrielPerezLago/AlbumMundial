import 'package:album_frontend/views/desktop/home_decktop.layout.dart';
import 'package:album_frontend/widgets/album_scafold.widget.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatefulWidget {
  Widget child;

  HomeView({
    required this.child
  });
  @override
  State<StatefulWidget> createState() => _HomeViewState();

}


class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) => HomeLayoutDesktop(child: widget.child);
}