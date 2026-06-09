import 'dart:convert';

import 'package:album_frontend/models/Carta.dart';
import 'package:album_frontend/services/HttpService.dart';

class AlbumService extends HttpService {
  static final String _father_endpoint_albumbasics = '/album-basics';
  static final String _father_endpoint_album = '/album';


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


  void _validateId(int? id) {
    if (id == null) {
      throw Exception("El id del Usuario es nulo , eso no puede ser");
    }
  }
}


