import 'package:flutter/material.dart';

class AnunciosTab extends StatefulWidget {
  @override
  _AnunciosTabState createState() => _AnunciosTabState();
}

class _AnunciosTabState extends State<AnunciosTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        RaisedButton(
          child: Text('Cadastrar Nova Vaga'),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/nova_vaga');
          },
        ),
//        SizedBox(height: 20.0),
//        Text('Não há vagas cadastradas')
      ],
    );
  }
}
