import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:flutter/material.dart';

class VagaPage extends StatefulWidget {
  @override
  VagaPageState createState() => VagaPageState();

  VagaPage(Vaga this._vaga);

  Vaga _vaga;
}

class VagaPageState extends State<VagaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("Vaga"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              this.widget._vaga.titulo,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: areas(),
            ),
            Text(
                this.widget._vaga.descricao,
                style: TextStyle(fontSize: 16.0)
            )
          ],
        ),
      ),
    );
  }

  List<Widget> areas() {
    List<Widget> lista = <Widget>[];

    if (this.widget._vaga.areas != null) {
      lista.add(Chip(
        avatar: Icon(Icons.bookmark),
        label: Text(this.widget._vaga.areas),
      ));
    }
    return lista;
  }
}