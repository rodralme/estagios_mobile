import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/helpers/config.areas.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:flutter/material.dart';

class VagaPage extends StatefulWidget {
  final Vaga vaga;

  VagaPage(this.vaga);

  @override
  _VagaPageState createState() => _VagaPageState();
}

class _VagaPageState extends State<VagaPage> {
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    Vaga vaga = this.widget.vaga;
    var areaConfig = Area.areaConfig[vaga.sigla];

    if (_loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar("Vaga"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(vaga.dataFormatada),
                Text(vaga.periodo()),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Divider(),
            Chip(
              label: Text(
                vaga.area,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              avatar: Icon(
                areaConfig['icon'],
                color: Colors.white,
                size: 20.0,
              ),
              backgroundColor: areaConfig['color'],
              padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            ),
            SizedBox(height: 10.0),
            Text(
              vaga.titulo,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              vaga.descricao,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(Icons.attach_money),
                SizedBox(width: 10.0),
                Text(vaga.remuneracao),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Icon(Icons.access_time),
                SizedBox(width: 10.0),
                Text(vaga.cargaHoraria),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Icon(Icons.alternate_email),
                SizedBox(width: 10.0),
                Text(vaga.email),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Icon(Icons.phone),
                SizedBox(width: 10.0),
                Text(vaga.telefone),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Icon(Icons.business_center),
                SizedBox(width: 10.0),
                Text(vaga.empresa),
              ],
            ),
            SizedBox(height: 20.0),
            banner(vaga.banner),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: botaoCandidatar(vaga),
            ),
          ],
        ),
      ),
    );
  }

  Widget banner(url) {
    print(url);
    if (url == null || url == '') return new SizedBox();
    return Center(
      child: Image.network(
        url,
      ),
    );
  }

  botaoCandidatar(Vaga vaga) {
    if (vaga.candidatado ?? false) {
      return Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            'Candidatado',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
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
          onPressed: () async {
            var conn = new Connection();
            Map data = await conn.post("vagas/${vaga.id}/candidatar");

            if (data['success'] == false) {
              Navigator.pushNamed(context, '/login');
              return;
            }

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VagaPage(Vaga.fromJson(data['data'])),
              ),
            );
          },
        ),
      ),
    );
  }
}
