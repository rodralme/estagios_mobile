import 'dart:convert' as convert;

import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/constants.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:estagios/pages/parts/VagaBox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VagasPage extends StatefulWidget {
  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {

//  int _page = 1;
//  int _totalItens = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("Vagas"),
      body: Container(
          child: lista()
      ),
    );
  }

  Future<List<Vaga>> fetchVagas(int page) async {
    final response = await http.get(
        "${Constants.API_ENDPOINT}/vagas?page=$page",
        headers: {
          "X-Access-Token": Constants.API_TOKEN
        }
    );

    if (response.statusCode == 200) {
      Map data = convert.jsonDecode(response.body);
      List<Vaga> vagas = new List<Vaga>();
      for (var vaga in data["data"]) {
        vagas.add(Vaga.fromJson(vaga));
      }
      return vagas;
    } else {
      throw Exception('erro');
    }
  }

  Widget lista() {
    return FutureBuilder<List<Vaga>>(
      future: fetchVagas(1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.grey),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {

              if (index < snapshot.data.length) {
                Vaga vaga = snapshot.data[index];
                return VagaBox(vaga);
              } else {
                // incrementar
              }
            }
          );
        }
      },
    );
  }
}
