import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/themes/equipo.theme.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:album_frontend/uitls/DateAppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cromo extends StatefulWidget {
  double widthPorcent;
  double heightPorcent;

  late final Carta carta;

  Cromo({
    required this.carta,
    required this.widthPorcent,
    required this.heightPorcent
  });

  @override
  State<Cromo> createState() => _CromoState();
}

class _CromoState extends State<Cromo> {
  late final _carta = widget.carta;
  late Color bgColor;

  @override
  void initState() {
    bgColor = ThemeEquipoColor(_carta.equipo.toString()) ?? Colors.black38;
  }


  late double txtSize = widget.widthPorcent * 50;


  @override
  Widget build(BuildContext context) => SizedBox(
    width: width(context) * widget.widthPorcent , //0.23,
    height: height(context) *  widget.heightPorcent, // 0.32,
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 20, blurStyle: BlurStyle.solid )
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: CustomPaint(
          size: Size.infinite,
          isComplex: true,
          painter: _BoxPainter(context: context),

          /**
           * TODO: Vista de la carta
           */


          child: LayoutBuilder(
              builder: (context, c) {
                final w = c.maxWidth;
                final h = c.maxHeight;

                return SafeArea(child: Column(
                  spacing: h * 0.05,
                  children: [
                    //TODO: Titulo Equipo
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(FormatDate(_carta.nacimiento!).toString(), style: TextStyle(fontSize: w * 0.05),),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerRight,
                            child: Text(_carta.equipo.toString().toUpperCase(), style: TextStyle(fontSize: w * 0.04), ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Container(
                            child: Image(
                              image: AssetImage('assets/img/user_icon.png'),
                              width: w * 0.45,
                            ),
                          ),
                          Container(
                            child: Text(_carta.nombre.toString().toUpperCase(), style: TextStyle(fontSize: w * 0.07),),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text('${_carta.peso.toString()} KG', style: TextStyle(fontSize: w * 0.05),),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text('${_carta.altura.toString()} CM', style: TextStyle(fontSize: w * 0.05),),
                            )
                          ],
                        )
                    )
                  ],
                )
                );
              }
          )

        ),
      )
    ),
  );
}

class _BoxPainter extends CustomPainter {
  BuildContext context;

  _BoxPainter({
    required this.context,
});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();

    final w = size.width;
    final h = size.height;

    paint.color = Colors.white24;

    paint.strokeWidth = 50;
    paint.style = PaintingStyle.fill;

    path.moveTo(w, h);
    path.lineTo(w, h*0.6);
    path.quadraticBezierTo(
        w*0.8, h*0.9, //Contol
        0, h*0.9 //Final
    );
    path.lineTo(0, h);


    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


