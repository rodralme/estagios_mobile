import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:estagios/pages/perfil/PerfilTab.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  final Pessoa pessoa;

  PerfilPage({Key key, @required this.pessoa}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: DefaultAppBar(
          "Perfil",
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Meus Dados',
              ),
              Tab(
                icon: Icon(Icons.wallpaper),
                text: 'Anúncios',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PerfilTab(pessoa: this.widget.pessoa),

            Text('teste'),
          ],
        ),
      ),
    );
  }
}
