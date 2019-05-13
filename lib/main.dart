import 'package:estagios/pages/HomePage.dart';
import 'package:estagios/pages/VagasPage.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(Estagios());

class Estagios extends StatelessWidget {

  final _title = 'Estágios';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(_title),
//        ),
//        body: Login()
//      ),
      home: VagasPage(),
      routes: <String, WidgetBuilder>{
        '/vagas': (context) => VagasPage()
      }
    );
  }
}
