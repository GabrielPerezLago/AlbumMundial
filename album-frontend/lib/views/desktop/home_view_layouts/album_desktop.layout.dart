
import 'package:album_frontend/controllers/AlbumController.dart';
import 'package:album_frontend/models/AlbumPage.dart';
import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/themes/equipo.theme.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/widgets/cards/cromo.widget.dart';
import 'package:album_frontend/widgets/cards/cromo_disable.widget.dart';
import 'package:album_frontend/widgets/loading/progress_indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumDesktop extends StatefulWidget {
  final session = SESSIONDATA.instance;
  final controller = AlbumController();

  @override
  State<StatefulWidget> createState() => _AlbumDesktop();
}

class _AlbumDesktop extends State<AlbumDesktop> {
  bool isLoading = true;

  late final session = widget.session;
  late final controller = widget.controller;

  AlbumPage? page;
  var pageBefore;
  var pageAfter;

  @override
  void initState() {
    _loadData();
  }

  void _loadData() async {
      page = (await controller.getAlbumPage(session.id!, 1))!;

      if (page != null) {
        setState(() {
          isLoading = false;
          pageBefore = page!.beforeEquipo;
          pageAfter = page!.afterEquipo;
        });
      }
  }

  @override
  Widget build(BuildContext context) => isLoading ? Container(alignment: Alignment.center, child: AlbumProgressIndicator()): SafeArea(
      child: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () async {
                      if (page!.beforeEquipo != null){
                        AlbumPage albm = (await controller.getAlbumPage(session.id!, page!.beforeEquipo!))!;
                        setState(() {
                          page = albm;
                        });
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios)
                ),
              ),
            ),

            Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    color: ThemeEquipoColor(page!.equipo!),
                    boxShadow: [
                      BoxShadow(color: Colors.white30, blurRadius: 20, blurStyle: BlurStyle.solid)
                    ]
                  ),
                  width: width(context) * 0.30,
                  height: height(context) *0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                          child: Text(page!.equipo!.toString().toUpperCase(), style: TextStyle(fontSize: width(context) * 0.04),),
                      ),
                      Expanded(
                        flex: 4,
                          child: SafeArea(child: SingleChildScrollView(
                            padding: EdgeInsets.all(7),
                            child: Wrap(
                              key: ValueKey(page!.equipo),
                              alignment: WrapAlignment.center ,
                              spacing: 30,
                              runSpacing: 50,
                              children: page!.cartas!.map(
                                      (carta) => carta.tiene!   ? Cromo(
                                        widthPorcent: 0.15,
                                        heightPorcent: 0.20,
                                        carta: carta,
                                      ) : CromoDisable(
                                          carta: carta,
                                          widthPorcent: 0.15,
                                          heightPorcent: 0.20,
                                      ),
                              ).toList(),
                            ),
                          ))
                      )
                    ],
                  )
                )
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () async {
                      if (page!.afterEquipo != null){
                        AlbumPage albm = (await controller.getAlbumPage(session.id!, page!.afterEquipo!))!;
                        setState(() {
                          page = albm;
                        });
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios_new_outlined, textDirection: TextDirection.rtl,)
                ),
              ),
            )
          ],
        ),
      )
  );
}