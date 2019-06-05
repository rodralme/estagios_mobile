import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();

  var _loading = false;
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    final _email = TextEditingController();
    final _password = TextEditingController();

    if (this.widget._loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar("Login"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.08),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
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
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Senha',
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
                    child: Text('Entrar'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        logar(_email.text, _password.text);
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

  void logar(email, password) async {
    setState(() {
      this.widget._loading = true;
    });
    var conn = new Connection();
    var data = await conn.post('login', {'email': email, 'password': password});

    setState(() {
      this.widget._loading = false;
    });

    if (data == null || data['success'] == false) {
      //
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', data['access_token']);

      Navigator.pushReplacementNamed(context, '/profile');
    }
  }
}
