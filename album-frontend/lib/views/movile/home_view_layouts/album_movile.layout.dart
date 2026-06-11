import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/AlbumPage.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/themes/equipo.theme.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/cards/cromo_disable.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumMovileLayout extends StatefulWidget {
  final session = SESSIONDATA.instance;
  final controller = AlbumController();

  @override
  State<StatefulWidget> createState() => _AlbumMovileLayout();
}


class _AlbumMovileLayout extends State<AlbumMovileLayout> {

  late final session = widget.session;
  late final controller = widget.controller;

  bool isLoading = true;

  AlbumPage? page;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final result = await controller.getAlbumPage(session.id!, 1);
    if (result != null) {
      setState(() {
        page = result;
        isLoading = false;
      });
    }
  }

  void _goTo(int equipoId) async {
    setState(() => isLoading = true);
    final result = await controller.getAlbumPage(session.id!, equipoId);
    if (result != null) {
      setState(() {
        page = result;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: AlbumProgressIndicator());
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              page!.equipo!.toString().toUpperCase(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ThemeEquipoColor(page!.equipo!),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 12)
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  key: ValueKey(page!.equipo),
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 16,
                  children: page!.cartas!.map((carta) =>
                  carta.tiene!
                      ? Cromo(widthPorcent:  0.4, heightPorcent: 0.5, carta: carta)
                      : CromoDisable(widthPorcent:  0.4, heightPorcent: 0.5, carta: carta),
                  ).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: page!.beforeEquipo != null
                      ? () => _goTo(page!.beforeEquipo!)
                      : null,
                  icon: Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: page!.afterEquipo != null
                      ? () => _goTo(page!.afterEquipo!)
                      : null,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
