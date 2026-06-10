import 'package:album_frontend/models/Carta.dart';

class AlbumPage{
  String? equipo;
  List<Carta>? cartas;
  int? beforeEquipo;
  int? afterEquipo;


  AlbumPage({
      this.equipo,
      this.cartas,
      this.beforeEquipo,
      this.afterEquipo,
  });


  factory AlbumPage.fromJson(Map<String, dynamic> json) => AlbumPage(
   equipo: json['equipoNombre'],
   cartas: (json['cartas'] as List).map((carta) => Carta.fromJson(carta) ).toList(),
    afterEquipo: json['afterEquipo'],
    beforeEquipo:json['beforeEquipo']
  );




}