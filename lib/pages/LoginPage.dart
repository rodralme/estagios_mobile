import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:estagios/pages/perfil/PerfilPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  var _loading = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    if (_loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.08),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaWidth * 0.2,
                vertical: mediaWidth * 0.1,
              ),
              child: Image.asset('assets/images/logo.png'),
            ),
            CampoTexto(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              icon: Icon(Icons.person),
              label: 'E-mail',
              rules: 'required|email',
            ),
            CampoTexto(
              controller: _password,
              icon: Icon(Icons.vpn_key),
              label: 'Senha',
              obscureText: true,
              rules: 'required',
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text('Entrar'),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                if (_loading) return;
                FocusScope.of(context).requestFocus(new FocusNode());
                if (formKey.currentState.validate()) {
                  logar();
                }
              },
            ),
            FlatButton(
              child: Text('Quero me cadastrar'),
              textColor: Colors.blue[800],
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }

  void logar() async {
    setState(() => _loading = true);

    try {
      var conn = new Connection();
      var data = await conn.post('login', {
        'email': _email.text,
        'password': _password.text,
      });

      if (data['success'] == false) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Usuário ou senha inválidos'),
          behavior: SnackBarBehavior.floating,
        ));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', data['meta']['access_token']);

        Pessoa pessoa = Pessoa.fromJson(data['data']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PerfilPage(pessoa: pessoa),
          ),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }
}
