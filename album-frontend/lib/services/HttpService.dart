import 'dart:convert';

import 'package:http/http.dart' as rest;

abstract class HttpService  {
  static final String _URL = "http://100.120.82.46:8080";

  Future<rest.Response> GET(String endpoint) async {
    final URI = Uri.parse('$_URL$endpoint');
    
    print('$URI');
    
    return await rest.get(
      URI,
      headers: {
        'Content-Type': 'application/json'
      }
    ).timeout(Duration(seconds: 7));
  }

  Future<rest.Response> POST (String endpoint, Map<String, dynamic> params) async  {
    final URI =  Uri.parse('$_URL$endpoint');

    print('$URI');

    return await rest.post(
      URI,
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(params)
    ).timeout(Duration(seconds: 7));

  }


  Future<rest.Response> POST_PATH (String endpoint) async {
    final URI = Uri.parse('$_URL$endpoint');

    print(URI);

    return await rest.post(
      URI,
      headers: {
        'Content-Type': 'application/json'
      }
    );
  }

}