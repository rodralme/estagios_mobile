import 'package:estagios/connection.dart';
import 'package:estagios/helpers/config.areas.dart';
import 'package:estagios/model/ItemVaga.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:estagios/pages/vagas/VagaPage.dart';
import 'package:flutter/material.dart';

class VagaBox extends StatelessWidget {
  VagaBox(this.vaga);

  final ItemVaga vaga;

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
                label: Text(vaga.area,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                avatar:
                    Icon(areaConfig['icon'], color: Colors.white, size: 20.0),
                backgroundColor: areaConfig['color'],
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    size: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      vaga.data,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              vaga.titulo,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            vaga.descricaoFormatada(),
            textAlign: TextAlign.justify,
          ),
          onTap: () async {
            var conn = new Connection();
            Map data = await conn.get("vagas/${vaga.id}");

            if (data['success'] == false) {
              // todo fazer
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VagaPage(Vaga.fromJson(data['data'])),
              ),
            );
          },
        ),
      ],
    );
  }
}
