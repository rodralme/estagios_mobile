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

  var vagas = new List<Vaga>();
  String next = "${Constants.API_ENDPOINT}/vagas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("Vagas"),
      body: Container(
          child: lista()
      ),
    );
  }

  Widget lista() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.grey),
      itemCount: vagas.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < vagas.length) {
          return VagaBox(vagas[index]);
        } else {
          if (next != null) {
            fetchVagas();
            return Container(child: Center(child: CircularProgressIndicator()));
          }
        }
      }
    );
  }

  Future<List<Vaga>> fetchVagas() async {
    print(next);
    final response = await http.get(
        next,
        headers: {"X-Access-Token": Constants.API_TOKEN});

    if (response.statusCode == 200) {
      Map data = convert.jsonDecode(response.body);
      for (var vaga in data["data"]) {
        setState(() {
          vagas.add(Vaga.fromJson(vaga));
        });
      }
      setState(() {
        next = data['links']['next'];
      });
    } else {
      throw Exception('Erro ao obter mais vagas');
    }
  }
}
