

import 'package:album_frontend/uitls/AdapterAppUtils.dart';
import 'package:flutter/material.dart';

/**
 * @params { Material Color }
 *
 * Widget que devuelve un contenedor que ocupa el 40% de ancho Y 50% del alto del padre
 *
 * @return Container
 */
class DesckContainer extends StatelessWidget {
  Widget? child;
  Color? color;


  DesckContainer({
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: width(context) * 0.4,
    height: height(context) * 0.5,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadiusGeometry.circular(20)
    ),
    child: child,
  );


}