import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/helpers/config.areas.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:flutter/material.dart';

class VagaPage extends StatelessWidget {
  VagaPage(this.vaga);

  final Vaga vaga;

  @override
  Widget build(BuildContext context) {
    var areaConfig = Area.areaConfig[this.vaga.sigla];

    return Scaffold(
        appBar: DefaultAppBar("Vaga"),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(vaga.createdAt),
                        Text(vaga.periodo()),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Divider(),
                    Chip(
                      label: Text(vaga.area,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      avatar: Icon(areaConfig['icon'],
                          color: Colors.white, size: 20.0),
                      backgroundColor: areaConfig['color'],
                      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                    ),
                    Text(
                      vaga.titulo,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.attach_money),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(vaga.remuneracao)),
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
                              child: Text(vaga.empresa)),
                        ],
                      ),
                    ),
                    Text(vaga.descricao,
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: SizedBox.expand(
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Candidatar',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.white,
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
