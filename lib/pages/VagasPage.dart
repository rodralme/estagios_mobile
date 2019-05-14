import 'package:estagios/model/Vaga.dart';
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

  List<Vaga> _vagas = [];
  int _page = 1;
  int _totalItens = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
//    _getVagas(1);
  }

//  void _getVagas(int page) async {
//    setState(() {
//      _loading = true;
//      _page = page;
//    });
//    http.Response response = await http.get(
//      "${Constants.API_ENDPOINT}/vagas?page=$page",
//      headers: {
//        "X-Access-Token": Constants.API_TOKEN
//      }
//    );
//    Map data = convert.jsonDecode(response.body);
//    setState(() {
//      _loading = false;
//      _vagas.addAll(data["data"]);
//      _totalItens = data["meta"]["total"];
//    });
//  }

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
    if (_loading && _page == 1) {
      return CircularProgressIndicator();
    }

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
                );
              } else {
                // incrementar
              }
            }
          );
        }
      },
    );

//    return ListView.separated(
//      separatorBuilder: (context, index) => Divider(color: Colors.grey),
//      itemCount: _vagas.length == _totalItens ? _vagas.length : _vagas.length + 1,
//      itemBuilder: (context, index) {
//        if (index < _vagas.length) {
//          return ListTile(
//            contentPadding: EdgeInsets.all(8),
//            title: Text(_vagas[index]["titulo"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//            subtitle: Text(_vagas[index]["descricao"], style: TextStyle(fontSize: 14)),
//            trailing: Icon(Icons.arrow_forward),
////            onTap: () {
////              Navigator.push(context, MaterialPageRoute(builder: (context) {
////                return NoticiaMilagrePalavraPage(_itens[index]);
////              }));
////            },
//          );
//        }
//        return Center(
//          child: _loading ? Padding(
//            padding: EdgeInsets.symmetric(vertical: 10),
//            child: Container(
//              width: 30,
//              height: 30,
//              child: CircularProgressIndicator(),
//            ),
//          ) : FlatButton(
//              onPressed: () {
//                _getVagas(_page + 1);
//              },
//              child: Text("MOSTRAR MAIS", style: TextStyle(color: Colors.blueAccent))
//          ),
//        );
//      }
//    );
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
