
import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InventoryDesktop extends StatefulWidget {
  final session = SESSIONDATA.instance;
  final controller = AlbumController();
  VoidCallback? onClick = (){};

  InventoryDesktop({
    this.onClick,
  });

  @override
  State<StatefulWidget> createState() => _InventoryDesktopState(onClick: onClick);

}

class _InventoryDesktopState extends State<InventoryDesktop> {

  VoidCallback? onClick = () {};

  late final controller = widget.controller;
  late final session = widget.session;
  late List<Carta> cartas;

  bool isLoading = true;

  _InventoryDesktopState({
    this.onClick
  });

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      cartas = (await controller.repetidas(session.id!))!;

      setState(() {
        isLoading = false;
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
        alignment: Alignment.center,
        child: AlbumProgressIndicator()
    ) :
    SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(width(context) * 0.03),
              alignment: Alignment.center,
              child: Wrap(
                spacing: width(context) * 0.05,
                runSpacing: 10,
                children: cartas.map((carta) =>
                    GestureDetector(
                      onTap: onClick,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Cromo(
                              heightPorcent: 0.20,
                              widthPorcent: 0.15,
                              carta: carta
                          ),
                          Text('x ${carta.cantidad.toString()}',
                            style: TextStyle(fontSize: width(context) * 0.012),)
                        ],
                      ),
                    )).toList(),
              )
          ),
        )
    );
  }
}
