import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: RaisedButton(
                child: Text('Entrar'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Submetido!!!'))
                    );
                  }
                }
              ),
            )
          ],
        )
      )
    );
  }
}