import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:estagios/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

  bool _loading = false;
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    if (this.widget._loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar("Cadastrar"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.08),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                controller: _password,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                },
              ),
              TextFormField(
                controller: _confirmation,
                decoration: const InputDecoration(
                  labelText: 'Confirmação da Senha',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Cadastrar'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        registrar();
                      }
                    },
                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    child: Text('Cadastrar'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      //
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

  void registrar() async {
    setState(() {
      this.widget._loading = true;
    });

    var conn = new Connection();
    var data = await conn.post('register', {
      'nome': _nome.text,
      'email': _email.text,
      'password': _password.text,
      'password_confirmation': _confirmation.text,
    });

    if (data == null || data['success'] == false) {
      //todo fazer
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', data['meta']['access_token']);

      Pessoa pessoa = Pessoa.fromJson(data['data']);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(pessoa: pessoa),
        ),
        ModalRoute.withName('/vagas'),
      );
    }

    setState(() {
      this.widget._loading = false;
    });
  }
}
