import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:flutter/material.dart';

class VagaPage extends StatefulWidget {
  @override
  VagaPageState createState() => VagaPageState();

  VagaPage(this._vaga);

  final Vaga _vaga;
}

class VagaPageState extends State<VagaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar("Vaga"),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Há 10 dias'),
                        Text('Período: 07/05 a 30/05'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Divider(),
                    Chip(
                      avatar: Icon(Icons.bookmark),
                      label: Text(this.widget._vaga.area),
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
                              child: Text(this.widget._vaga.remuneracao)),
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
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Candidatar',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        //
                      },
                    ),
                  ),
                ),
              ),
            ]));
  }
}
