import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
    print(response.toString());
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
    print(response.body);
    throw new Exception('Erro ao realizar a requisição.');
  }

  dynamic put(String url, [Map<String, String> params]) async {
    var unencodedPath = 'api/' + url;
    var uri = Uri.https(Constants.API_ENDPOINT, unencodedPath, params);
    var headers = await getHeaders();
    final response = await http.put(uri, headers: headers);

    if ([200, 422, 401].contains(response.statusCode)) {
      return jsonDecode(response.body);
    }
    print(response.toString());
    throw new Exception('Erro ao realizar a requisição.');
  }

//  dynamic upload(File file) async {
//    if (file == null) return null;
//
//    Dio dio = new Dio();
//    var headers = await getHeaders();
//    dio.options.headers = headers;
//    dio.options.baseUrl = 'https://' + Constants.API_ENDPOINT;
//    var response = dio.post('/upload', data: {
//      'image': await MultipartFile.fromFile(basename(file.path))
//    });
//    formdata.add("image", new UploadFileInfo(_image, basename(_image.path)));
//
//  }

  dynamic upload(File file) async {
    if (file == null) return null;

    var headers = await getHeaders();
////    headers['content-type'] = 'multipart/form-data';
//    final response = await http.post(
//        'https://' + Constants.API_ENDPOINT + '/api/upload',
//        headers: headers,
//        body: {"image": base64Encode(file.readAsBytesSync())},
//    );
//
//    if ([200, 422, 401].contains(response.statusCode)) {
//      return jsonDecode(response.body);
//    }
//
//    print(response.body);
//    throw new Exception('Erro ao realizar a requisição.');

    var dio = new Dio();
    dio.options.baseUrl = 'https://' + Constants.API_ENDPOINT + '/api';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = headers;

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path)
    });
    var response = await dio.post("/upload", data: formData);

    if ([200, 422, 401].contains(response.statusCode)) {
      return response.data;
    }

    throw new Exception('Erro ao realizar a requisição.');
  }
}
