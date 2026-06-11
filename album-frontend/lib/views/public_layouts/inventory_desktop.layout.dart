
import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InventoryLayout extends StatefulWidget {
  final session = SESSIONDATA.instance;
  final controller = AlbumController();
  VoidCallback? onClick = (){};


  InventoryLayout({
    this.onClick,
  });

  @override
  State<StatefulWidget> createState() => _InventoryState(onClick: onClick);

}

class _InventoryState extends State<InventoryLayout> {

  VoidCallback? onClick = () {};

  late final controller = widget.controller;
  late final session = widget.session;
  late List<Carta> cartas;

  bool isLoading = true;

  _InventoryState({
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
                              heightPorcent: isDesktop ? 0.2: 0.5,
                              widthPorcent: isDesktop ? 0.15: 0.4,
                              carta: carta
                          ),
                          Text('x ${carta.cantidad.toString()}',
                            style: TextStyle(fontSize:  isDesktop ? width(context) * 0.012: width(context) * 0.05)),
                        ],
                      ),
                    )).toList(),
              )
          ),
        )
    );
  }
}
