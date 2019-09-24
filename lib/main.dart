import 'package:estagios/pages/LoginPage.dart';
import 'package:estagios/pages/RegisterPage.dart';
import 'package:estagios/pages/vagas/VagasPage.dart';
import 'package:flutter/material.dart';

import 'components/default_app_bar.dart';

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
          '/login': (context) => Scaffold(
                appBar: DefaultAppBar("Login"),
                body: LoginPage(),
              ),
          '/register': (context) => RegisterPage(),
          '/vagas': (context) => VagasPage(),
        });
  }
}
