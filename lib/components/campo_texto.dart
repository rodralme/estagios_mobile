import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  CampoTexto({
    this.controller,
    this.keyboardType = TextInputType.text,
    this.label,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        return value.isEmpty ? 'Campo obrigatório' : null;
      },
    );
  }
}
