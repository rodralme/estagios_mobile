import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = 'Estágios';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Login()
      )
    );
  }
}

class ListaVagas extends StatefulWidget {
  @override
  _ListaVagasState createState() => _ListaVagasState();
}

class _ListaVagasState extends State<ListaVagas> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Text(
              'I',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
          ),
          title: Text('Map'),
          subtitle: Text('bla bla bla'),
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
          subtitle: Text('bla bla bla'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
          subtitle: Text('bla bla bla'),
        ),
      ],
    );
  }
}
