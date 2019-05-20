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
        body: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Em: 15 Mai'),
                      ),
                      Expanded(
                          child: Text('Período: 07/05 a 30/05',
                              textAlign: TextAlign.right)),
                    ],
                  ),
                  Divider(),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: areas(),
                  ),
                  Text(this.widget._vaga.titulo,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(this.widget._vaga.remuneracao))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 10.0, left: 2.0, right: 2.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.business_center),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(this.widget._vaga.empresa)),
                      ],
                    ),
                  ),
                  Text(this.widget._vaga.descricao,
                      style: TextStyle(fontSize: 16.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
              color: Colors.lightGreen,
              padding: EdgeInsets.all(0),
              child: Text('Candidatar'),
              onPressed: () {
                //
              },
            ),
          )
        ]));
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
