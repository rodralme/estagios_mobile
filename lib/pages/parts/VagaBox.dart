import 'package:estagios/helpers/config.areas.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:estagios/pages/VagaPage.dart';
import 'package:flutter/material.dart';

class VagaBox extends StatelessWidget {

  VagaBox(this.vaga);

  final Vaga vaga;

  @override
  Widget build(BuildContext context) {

    var areaConfig = Area.areaConfig[this.vaga.sigla];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Chip(
                label: Text(
                    vaga.area,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )
                ),
                avatar: Icon(areaConfig['icon'], color: Colors.white, size: 20.0),
                backgroundColor: areaConfig['color'],
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.access_time),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(vaga.createdAt),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(vaga.titulo, overflow: TextOverflow.ellipsis),
          subtitle: Text(vaga.descricaoFormatada()),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return VagaPage(vaga);
            }));
          },
        ),
      ],

    );
  }}