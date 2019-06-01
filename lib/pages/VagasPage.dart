import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Area.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:estagios/pages/parts/VagaBox.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatefulWidget {
  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  List<DropdownMenuItem<String>> _filtroArea = [];
  var _currArea = '';

  var vagas = new List<Vaga>();
  String next = "/vagas";

  @override
  void initState() {
    popularFiltroArea();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        "Estágios",
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            tooltip: 'Usuário',
            iconSize: 26.0,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            filtro(),
            Expanded(child: lista()),
          ],
        ),
      ),
    );
  }

  Widget filtro() {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Color.fromARGB(255, 38, 60, 81),
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color.fromARGB(255, 38, 60, 81),
          ),
          child: DropdownButton(
            value: _currArea,
            items: _filtroArea,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            onChanged: (String value) {
              setState(() {
                _currArea = value;
              });
            },
          ),
        ),
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
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
      },
    );
  }

  void fetchVagas() async {
    var conn = new Connection();
    Map data = await conn.get(next);

    for (var vaga in data['data']) {
      setState(() {
        vagas.add(Vaga.fromJson(vaga));
      });
    }
    setState(() {
      next = data['links']['next'];
    });
  }

  void popularFiltroArea() async {
    var conn = new Connection();
    var data = await conn.get('/areas');

    _filtroArea.add(new DropdownMenuItem(
      value: '',
      child: new Text('Todos'),
    ));

    for (var item in data) {
      Area area = Area.fromJson(item);
      _filtroArea.add(new DropdownMenuItem(
        value: area.sigla,
        child: new Text(area.nome),
      ));
    }
  }
}
