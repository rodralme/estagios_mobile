import 'package:flutter/material.dart';

class BotaoHome extends StatelessWidget {

  BotaoHome(this._name, {this.onPressed});

  final String _name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        child: Text(this._name),
        padding: EdgeInsets.all(0),
        onPressed: this.onPressed == null
            ? () {
              Navigator.pushNamed(context, "/${this._name}");
            }
            : this.onPressed,
      ),
    );
//    return Expanded(
//      child: FlatButton(
//        child: Image.asset("images/${this._name}.png", fit: BoxFit.cover),
//        padding: EdgeInsets.all(0),
//        onPressed: this.onPressed == null ? () {
//          Navigator.pushNamed(context, "/${this._name}");
//        } : this.onPressed,
//      ),
//    );
  }
}