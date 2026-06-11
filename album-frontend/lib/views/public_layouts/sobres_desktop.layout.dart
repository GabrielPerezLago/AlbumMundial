
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

class SobresLayout extends StatefulWidget {
  final controller = AlbumController();
  final session = SESSIONDATA.instance;


  @override
  State<StatefulWidget> createState() => _SobresLayoutState();

}

class _SobresLayoutState extends State<SobresLayout> {
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
            if (isLoading) return;

            isLoading = true;

            cartas = sobre.cartas;
            cromos = cartas.map((carta) =>
                Cromo(
                  heightPorcent: isDesktop ? 0.20 : 0.6,
                  widthPorcent: isDesktop ? 0.15 : 0.4,
                  carta: carta,
                )).toList();

            await controller.saveCartas(session.id!, sobre.cartas);
            setState(() {
              sobres.remove(sobre);
              showSobres = false;
              isLoading = false;
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

  Widget SwipperSobres() {
    final w = width(context);
    final h = height(context);

    return SafeArea(
      child: Center(
        child: Swiper(
          axisDirection: AxisDirection.left,
          layout: SwiperLayout.STACK,
          itemCount: sobres.length,
          duration: 2,
          scrollDirection: Axis.horizontal,

          containerWidth: isMovile ? w : w * 0.1,
          itemWidth: isMovile ? w * 0.7 : w * 0.2,
          itemHeight: isMovile ? h * 0.7 : h * 0.4,

          itemBuilder: (context, index) {
            final _sobre = sobres[index];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _sobre,
                  const SizedBox(height: 10),
                  Text('Sobre ${index + 1}')
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget SwiperCartas() {
    final w = width(context);
    final h = height(context);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),

          Expanded(
            child: Swiper(
              axisDirection: AxisDirection.left,
              layout: SwiperLayout.STACK,
              itemCount: cartas.length,
              duration: 6,
              scrollDirection: Axis.horizontal,

              containerWidth: isMovile ? w : w * 0.1,
              itemWidth: isMovile ? w * 0.7 : w * 0.3,
              itemHeight: isMovile ? h * 0.7 : h * 0.5,

              itemBuilder: (context, index) {
                final _cromo = cromos[index];

                return Center(
                  child: _cromo,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showSobres = true;
                  cartas = [];
                  cromos = [];
                });
              },
              child: const Text('Cerrar'),
            ),
          )
        ],
      ),
    );
  }

}