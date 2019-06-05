import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

  var _loading = false;
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (this.widget._loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

//    return Scaffold(
//      appBar: DefaultAppBar("Perfil"),
//      body: Container(
//        child: RaisedButton(
//          child: Text('Deslogar'),
//          onPressed: () async {
//            this.widget._loading = true;
//            var connection = new Connection();
//            var data = await connection.post('logout');
//
//            this.widget._loading = false;
//          },
//        ),
//      ),
//    );

    return Scaffold(
      appBar: DefaultAppBar("Perfil"),
      body: Container(
        child: Center(
          child: Text(
            'Em construção!',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
