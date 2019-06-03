import 'dart:convert' as convert;

import 'package:estagios/constants.dart';
import 'package:http/http.dart' as http;

class Connection {
  final headers = {
//    "Authorization": Constants.API_TOKEN,
  };

  dynamic get(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url.replaceAll('/', '');
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw new Exception(response.statusCode.toString());
    }
    return convert.jsonDecode(response.body);
  }

  dynamic post(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url.replaceAll('/', '');
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    final response = await http.post(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        print('Não autorizado');
        return null;
      }
      throw new Exception('Erro ao realizar a requisição.');
    }
    return convert.jsonDecode(response.body);
  }
}
