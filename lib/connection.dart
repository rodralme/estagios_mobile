import 'dart:convert';
import 'dart:io';

import 'package:estagios/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Connection {

  dynamic getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString('access_token') ?? '';

    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $auth",
    };
  }

  dynamic get(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url;
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    var headers = await getHeaders();
    final response = await http.get(uri, headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      return jsonDecode(response.body);
    }
    throw new Exception('Erro ao realizar a requisição.');
  }

  dynamic post(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url;
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    var headers = await getHeaders();
    final response = await http.post(uri, headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      return jsonDecode(response.body);
    }
    throw new Exception('Erro ao realizar a requisição.');
  }
}
