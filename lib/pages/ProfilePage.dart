import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {

  final Pessoa pessoa;

  ProfilePage({Key key, @required this.pessoa}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var _loading = false;

    void deslogar() async {
      _loading = true;

      var connection = new Connection();
      var data = await connection.post('logout');

      if (data != null && data['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('access_token');
        Navigator.pushReplacementNamed(context, '/login');
      }
      // todo enviar a mensagem caso não deslogue

      _loading = false;
    }

    if (_loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar("Perfil"),
      body: Container(
        child: RaisedButton(
          child: Text('Deslogar'),
          onPressed: () {
            deslogar();
          },
        ),
      ),
    );
  }
}
