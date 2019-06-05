import 'dart:convert' as convert;

import 'package:estagios/constants.dart';
import 'package:http/http.dart' as http;

class Connection {
  final headers = {
    'Accept': 'application/json',
  };

  dynamic get(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url.replaceAll('/', '');
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw new Exception(response.statusCode.toString());
    }
    return convert.jsonDecode(response.body);
  }

  dynamic post(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url.replaceAll('/', '');
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    final response = await http.post(uri, headers: headers);

    if (response.statusCode >= 500) {
      throw new Exception('Erro ao realizar a requisição.');
    }
    return convert.jsonDecode(response.body);
  }
}
