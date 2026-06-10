import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/widgets/cards/sobre.widget.dart';

class SobreDTO {
  List<Carta> cartas;

  SobreDTO({
    required this.cartas
});

  factory SobreDTO.fromJson(List<dynamic> json) => SobreDTO(
    cartas: json.map((carta) => Carta.fromJson(carta as Map<String, dynamic>)).toList()
  );


}