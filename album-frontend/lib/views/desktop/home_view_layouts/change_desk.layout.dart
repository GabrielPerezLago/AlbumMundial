import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/views/desktop/wizard/repetidas.wzard.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeDeskLayout extends StatefulWidget {
  final session = SESSIONDATA.instance;
  final controller = AlbumController();
  @override
  State<StatefulWidget> createState() => _ChangeDesckState();
}

class _ChangeDesckState extends State<ChangeDeskLayout> {
  late final session = widget.session;
  late final controller = widget.controller;
  bool isLoading = true;
  List<Carta>? _cartas;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _cartas = await controller.cartasNoTine(session.id!);

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ?
      Container(
        alignment: Alignment.center,
        child: AlbumProgressIndicator(),
      ) :
    SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Wrap(
              spacing: width(context) * 0.1,
              runSpacing: 60,
              children: _cartas?.map((carta) =>Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cromo(
                      heightPorcent: 0.20,
                      widthPorcent: 0.15,
                      carta: carta
                  ),
                  ElevatedButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return RepetidasWizard(idCartaPedida: carta.id!,);
                            }
                        );
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Text('Cambiar')
                  )
                ],
              )).toList() ?? [Text('No hay cartas')],
          )
        ),
      )
    );
  }

}