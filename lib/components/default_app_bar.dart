import 'package:flutter/material.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar(_title, {Key key, Widget bottom}) : super(
    key: key,
    title: Text(_title),
    centerTitle: true,
    bottom: bottom,
    backgroundColor: Color.fromARGB(255, 18, 33, 51)
  );
}