import 'package:album_frontend/models/SobreDTO.dart';
import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  VoidCallback? onClick = (){};

  Sobre({
    this.onClick
  });

@override
  State<Sobre> createState() => _SobreState(onClick: onClick!);
}

class _SobreState extends State<Sobre> {
  VoidCallback onClick;

  int counter = 0;

  double scale = 1.0;

  _SobreState({
   required this.onClick
});

  void _onTap() async {
    counter++;

    if (counter >= 3) this.onClick();

    setState(() {
      scale = 1.2;
    });

    await Future.delayed(Duration(milliseconds: 200));

    setState(() {
      scale = 1.0;
    });
  }

@override
Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedScale(
      scale: scale,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: Container(
          width: width(context) * 0.2,
          height: height(context) * 0.25,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
             image: AssetImage('assets/img/sobre.png'),
              fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
  }
}
