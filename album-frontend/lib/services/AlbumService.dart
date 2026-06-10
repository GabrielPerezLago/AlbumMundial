import 'dart:convert';

import 'package:album_frontend/models/AlbumPage.dart';
import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/models/SobreDTO.dart';
import 'package:album_frontend/services/HttpService.dart';
import 'package:album_frontend/widgets/cards/sobre.widget.dart';

class AlbumService extends HttpService {
  static final String _father_endpoint_albumbasics = '/album-basics';
  static final String _father_endpoint_album = '/album';
  static final String _father_endpoint_cartas = '/cartas';


  Future<List<Carta>?> cartasRepetidas(int? idUsuario) async {
    try {
      _validateId(idUsuario);
        final response = await super.POST_PATH('$_father_endpoint_albumbasics/repetidas/$idUsuario');
        if (response.statusCode == 200) {
          final List<dynamic> cartasJson = jsonDecode(response.body);
          final List<Carta> cartas = cartasJson.map((carta) => Carta.fromJson(carta)).toList();
          return cartas;
        } else  {
          return null;
        }
      } catch (ex) {
        throw Exception('Error: $ex');
      }
  }

  Future<List<Carta>?> cartasNoTiene(int? idUsuario) async {
    try {
      _validateId(idUsuario);
      final response = await super.POST_PATH('$_father_endpoint_albumbasics/cartas-no-usuario/$idUsuario');

      if (response.statusCode == 200) {
        final List<dynamic> cartasJson = jsonDecode(response.body);
        final List<Carta> cartas = cartasJson.map((carta) => Carta.fromJson(carta)).toList();
        return cartas;
      } else {
        return null;
      }

    } catch (ex) {
      throw Exception('Exception: $ex');
    }
  }


  Future<bool> intercambio(int idUser, int idCartaOfrecida, int idCartaPedida) async {
    final response = await super.POST(
        '$_father_endpoint_album/intercambio',
        {
          "idUsuario": idUser,
          "idCartaUsuario": idCartaOfrecida,
          "idCartaPedida": idCartaPedida
        }
       );

    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch(ex) {
      throw Exception('Exception: $ex') ;
    }
  }

  Future<List<SobreDTO>?> getSobres() async {
    final response = await super.GET('$_father_endpoint_cartas/sobres');
  
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data as List)
            .map((sobre) => SobreDTO.fromJson(sobre))
            .toList();
      } else {
        return null;
      }

    } catch(ex) {
      throw Exception("Exception : $ex");
    }
  }
  
  Future<void> saveCartas(int idUsuario, Map<int, int> cartaCantida) async {
    try {
      final res =  await super.POST(
        '$_father_endpoint_album/save',
        {
          'idUsuario': idUsuario,
          'cartaCantidad':cartaCantida.map(
                (key, value) => MapEntry(key.toString(), value),
          ),
        }
      );
    } catch(ex) {
      throw Exception('Exception: $ex');
    }
  }

  Future<AlbumPage?> getAlbumPage(int idUsuario, int idEquipo) async {
    try {
      final res = await super.POST_PATH(
          '$_father_endpoint_albumbasics/page?usuario=$idUsuario&equipo=$idEquipo'
      );
      if (res.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(res.body);
        return AlbumPage.fromJson(data);
      } else {
        return null;
      }

    } catch (ex) {
      throw Exception('Exception >> $ex');
    }
  }

  void _validateId(int? id) {
    if (id == null) {
      throw Exception("El id del Usuario es nulo , eso no puede ser");
    }
  }
}


