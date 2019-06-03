import 'dart:convert' as convert;

import 'package:estagios/constants.dart';
import 'package:http/http.dart' as http;

class Connection {
  final headers = {
//    "X-Access-Token": Constants.API_TOKEN,
  };

  dynamic get(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url.replaceAll('/', '');
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    print(uri.toString());
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw new Exception(response.statusCode.toString());
    }
    return convert.jsonDecode(response.body);
  }
}
