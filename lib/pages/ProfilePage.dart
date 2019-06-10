import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masked_text/masked_text.dart';

class ProfilePage extends StatelessWidget {
  final Pessoa pessoa;

  ProfilePage({Key key, @required this.pessoa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    final _nome = TextEditingController(text: pessoa.nome);
    final _email = TextEditingController(text: pessoa.email);
    final _nascimento = TextEditingController(text: pessoa.nascimento);
    final _telefone1 = TextEditingController(text: pessoa.telefone1);
    final _telefone2 = TextEditingController(text: pessoa.telefone2);
    final _sobre = TextEditingController(text: pessoa.sobre);

    return Scaffold(
      appBar: DefaultAppBar("Perfil"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.08),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                },
              ),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                },
              ),
              TextFormField(
                controller: _nascimento,
                keyboardType: TextInputType.datetime,
                maxLength: 15,
                decoration: const InputDecoration(
                  labelText: 'Nascimento',
                ),
              ),
              MaskedTextField(
                maskedTextFieldController: _telefone1,
                mask: "(xx) xxxxx-xxxx",
                maxLength: 15,
                keyboardType: TextInputType.phone,
                inputDecoration: new InputDecoration(
                  labelText: "Telefone",
                ),
              ),
              TextFormField(
                controller: _sobre,
                decoration: const InputDecoration(
                  labelText: 'Sobre',
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Salvar'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        salvar(context);
                      }
                    },
                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    child: Text('Deslogar'),
                    color: Colors.red[700],
                    textColor: Colors.white,
                    onPressed: () {
                      deslogar(context);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void salvar(BuildContext context) async {
    var connection = new Connection();
    var data = await connection.put("pessoas/${pessoa.id}");

    if (data['success']) {
      // todo fazer algo
    }
  }

  void deslogar(context) async {
    var connection = new Connection();
    var data = await connection.post('logout');

    if (data['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
    }
    Navigator.pushReplacementNamed(context, '/login');
  }
}
