import 'package:estagios/model/Vaga.dart';
import 'package:estagios/pages/VagaPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/constants.dart';
import 'dart:convert' as convert;

class VagasPage extends StatefulWidget {
  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {

//  int _page = 1;
//  int _totalItens = 0;

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
                var vaga = snapshot.data[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('A'),
                  ),
                  title: Text(vaga.titulo),
                  subtitle: Text(vaga.descricao),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return VagaPage(vaga);
                    }));
                  },
                );
              } else {
                // incrementar
              }
            }
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("Vagas"),
      body: Container(
        child: lista()
      ),
    );
  }
}
