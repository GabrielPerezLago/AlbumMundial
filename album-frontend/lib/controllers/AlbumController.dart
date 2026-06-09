import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/services/AlbumService.dart';

class AlbumController {
  static final _service = AlbumService();

  
  Future<List<Carta>?> cartasNoTine(int idUsuario) async => await _service.cartasNoTiene(idUsuario);
  Future<List<Carta>?> repetidas(int idUsuario) async => await _service.cartasRepetidas(idUsuario);
  Future<bool> intercambio(int idUser, int idCartaOfrecida, int idCartaPedida) async => await _service.intercambio(idUser, idCartaOfrecida, idCartaPedida);

}