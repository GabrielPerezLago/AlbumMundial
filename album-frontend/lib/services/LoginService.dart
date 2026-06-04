import 'dart:convert';

import 'package:album_frontend/models/SESSION.dart';
import 'package:album_frontend/services/HttpService.dart';

class LoginService extends HttpService {
  static final session = SESSIONDATA.instance;

  Future<bool> signin(String email, String password) async {
    print('email: $email: password: $password');
    final response = await super.POST('/auth/signin', {
      'email': email,
      'password': password
    });
    
    print(response.statusCode);
    print(response.body);

    try {
      if (response.statusCode == 200) {
        _toInitSession(jsonDecode(response.body));
        return true;
      } else  {
        return false;
      }
    } catch(ex) {
      throw Exception("Error Al intentar inciar session : $ex");
    }



  }

  Future<bool> signup(String name, String email, String password) async {
    final response = await super.POST('/auth/signup', {
      'nombre': name,
      'email': email,
      'password': password
    });

    try{
      if (response.statusCode == 200) {
        _toInitSession(jsonDecode(response.body));
        return true;
      } else {
        return false;
      }
    } catch(ex) {
      throw Exception("A habido algun error al registrarse $ex");
    }
  }

  void _toInitSession(Map<String, dynamic> params) {
    session.saveData(params);
  }
}