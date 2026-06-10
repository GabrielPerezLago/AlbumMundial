import 'package:album_frontend/models/AlbumPage.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SobreDTO.dart';
import 'package:album_frontend/services/AlbumService.dart';

class AlbumController {
  static final _service = AlbumService();

  
  Future<List<Carta>?> cartasNoTine(int idUsuario) async => await _service.cartasNoTiene(idUsuario);
  Future<List<Carta>?> repetidas(int idUsuario) async => await _service.cartasRepetidas(idUsuario);
  Future<bool> intercambio(int idUser, int idCartaOfrecida, int idCartaPedida) async => await _service.intercambio(idUser, idCartaOfrecida, idCartaPedida);
  Future<List<SobreDTO>?> sobres() async => await _service.getSobres();
  Future<void> saveCartas( int idUsuario, List<Carta> cartas )  async {
    Map<int, int> cartaCantidad = {};

    for (final carta in cartas) {
      if (carta.id == null) continue;

      cartaCantidad[carta.id!] = (cartaCantidad[carta.id!] ?? 0) + 1;
    }

   await _service.saveCartas(idUsuario, cartaCantidad);
  }

  Future<AlbumPage?> getAlbumPage(int idUsuario, int idEquipo) async => await _service.getAlbumPage(idUsuario, idEquipo);

}