import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:estagios/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _loading = false;

  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    if (this._loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar("Cadastrar"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.08),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaWidth * 0.3,
                  vertical: mediaWidth * 0.08,
                ),
                child: Image.asset('assets/images/logo.png'),
              ),
              CampoTexto(
                controller: _nome,
                label: 'Nome',
                rules: 'required',
              ),
              CampoTexto(
                controller: _email,
                label: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                rules: 'required|email',
              ),
              CampoTexto(
                controller: _password,
                label: 'Senha',
                obscureText: true,
                rules: 'required',
              ),
              CampoTexto(
                controller: _confirmation,
                label: 'Confirmação da Senha',
                obscureText: true,
                rules: 'required',
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
                        registrar(context);
                      }
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

  void registrar(_context) async {
    setState(() => _loading = true);

    var conn = new Connection();
    var data = await conn.post('register', {
      'nome': _nome.text,
      'email': _email.text,
      'password': _password.text,
      'password_confirmation': _confirmation.text,
    });

    try {
      if (data == null || data['success'] == false) {
        //todo fazer
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', data['meta']['access_token']);

        Pessoa pessoa = Pessoa.fromJson(data['data']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(pessoa: pessoa),
          ),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }
}
