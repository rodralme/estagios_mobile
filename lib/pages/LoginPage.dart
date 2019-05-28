import 'package:estagios/components/default_app_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double mediaWidth = MediaQuery.of(context).size.width;

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
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Submetido!!!'))
                        );
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
          )
        )
      ),
    );
  }
}