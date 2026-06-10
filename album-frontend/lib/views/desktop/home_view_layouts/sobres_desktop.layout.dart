
import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/models/SobreDTO.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/cards/sobre.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class SobresDesktop extends StatefulWidget {
  final controller = AlbumController();
  final session = SESSIONDATA.instance;


  @override
  State<StatefulWidget> createState() => _SobresDescktopState();

}

class _SobresDescktopState extends State<SobresDesktop> {
  late final controller = widget.controller;
  late final session = widget.session;

  bool isLoading = true;
  bool showSobres = true;


  List<SobreDTO>? sobresDTO = [];
  List<Sobre> sobres = [];

  //Todo: Listas de cartas y cromos;
  List<Carta> cartas = [];
  List<Cromo> cromos = [];

  @override
  void initState() {
    _loadData();
  }

  _loadData() async {
    if (sobresDTO == null || sobresDTO!.isEmpty) {
      sobresDTO = await controller.sobres()!;
    }

    setState(() {
      if (!sobresDTO!.isEmpty) {
          sobres = sobresDTO!.map((sobre) => Sobre(
          onClick: () async {
            cartas = sobre.cartas;
            cromos = cartas.map((carta) =>
                Cromo(
                  heightPorcent: 0.2,
                  widthPorcent: 0.15,
                  carta: carta,
                )).toList();

            await controller.saveCartas(session.id!, sobre.cartas);
            setState(() {
              sobres.remove(sobre);
              showSobres = false;
            });
          })).toList();
          isLoading = false;
        };
    });
  }

  @override
  Widget build(BuildContext context) => isLoading ? this.Loading():
      showSobres ? SwipperSobres() : SwiperCartas();


  Widget Loading() => Container(
    alignment: Alignment.center,
    child: AlbumProgressIndicator(),
  );

  Widget SwipperSobres() => SafeArea(
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Swiper(
            axisDirection: AxisDirection.left,
            containerWidth: width(context) * 0.1,
            layout: SwiperLayout.STACK,
            itemCount: sobres.length,
            duration: 2,
            scrollDirection: Axis.horizontal,
            itemHeight: height(context) * 0.4,
            itemWidth: width(context) * 0.20,
            itemBuilder: (context, index) {
              final _sobre = sobres[index];
              return Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _sobre,
                    Text('Sobre ${index + 1}')
                  ],
                ),
              );
            }),
      ),
    ),
  );

  Widget SwiperCartas() => SafeArea(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Swiper(
                axisDirection: AxisDirection.left,
                containerWidth: width(context) * 0.1,
                layout: SwiperLayout.STACK,
                itemCount: cartas.length,
                duration: 6,
                scrollDirection: Axis.horizontal,
                itemHeight: height(context) * 0.4,
                itemWidth: width(context) * 0.3,
                itemBuilder: (context, index) {
                  final _cromo = cromos[index];
                  return Container(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _cromo
                      ],
                    ),
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                    setState(() {
                      showSobres = true;
                      cartas = [];
                      cromos = [];
                    });
                },
                child: Text('Cerrar', style: TextStyle(color: Colors.green),)
            ),
          )
        ],
      )
    ),
  );

}