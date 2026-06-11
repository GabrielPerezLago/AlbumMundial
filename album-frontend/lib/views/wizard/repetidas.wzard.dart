import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepetidasWizard extends StatefulWidget {
  final session = SESSIONDATA.instance;
  final controller = AlbumController();

  final int idCartaPedida;

  RepetidasWizard({
    required this.idCartaPedida
  });

  @override
  State<StatefulWidget> createState() => _RepetidasWizardState(idCartaPedida: this.idCartaPedida);
}

class _RepetidasWizardState extends State<RepetidasWizard> {
  final int idCartaPedida;
  bool isLoading = true;

  late final controller = widget.controller;
  late final session = widget.session;
  late List<Carta> cartas;

  _RepetidasWizardState({
    required this.idCartaPedida
  });

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  _loadData() async {
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
  Widget build(BuildContext context) => Dialog(
    child: isLoading ? Container(
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
                      onTap: () async {
                        bool res = await controller.intercambio(session.id!, carta.id!, this.idCartaPedida);
                        if (res) {
                          Navigator.pop(context);
                        } else {
                          showDialog(context: context, builder: (context) {
                            return Dialog( child: Text('Algo a salido mal , no se ha podido cambiar la carta'),);
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Cromo(
                              heightPorcent: isDesktop ? 0.20 : 0.5,
                              widthPorcent: isDesktop ? 0.15 : 0.4,
                              carta: carta
                          ),
                          Text('x ${carta.cantidad.toString()}',
                            style: TextStyle(fontSize: isDesktop ? width(context) * 0.012: width(context) * 0.03),)
                        ],
                      ),
                    )).toList(),
              )
          ),
        )
    )
  );
  
}