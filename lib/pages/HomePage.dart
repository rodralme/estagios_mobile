import 'package:estagios/components/botao_home.dart';
import 'package:estagios/components/default_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("Estágios"),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
//          Image.asset("images/background.jpg", fit: BoxFit.cover),
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    BotaoHome("vagas"),
                    BotaoHome("fotos"),
                    BotaoHome("mensagem_ap"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    BotaoHome("palavras"),
                    BotaoHome("milagres"),
                    BotaoHome("noticias"),
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }
}
