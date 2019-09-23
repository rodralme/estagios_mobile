import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

class CampoTexto extends StatelessWidget {
  CampoTexto({
    this.controller,
    this.keyboardType = TextInputType.text,
    this.label,
    this.icon,
    this.obscureText = false,
    this.rules,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final Icon icon;
  final bool obscureText;
  final String rules;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        icon: icon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        for (var rule in rules.split('|')) {
          var msg = validar(value, rule);
          if (msg != null) {
            return msg;
          }
        }
        return null;
      },
    );
  }

  validar(value, rule) {
    switch (rule) {
      case 'required': {
        return value.isEmpty ? 'Campo obrigatório' : null;
      }
      case 'email': {
        return !isEmail(value) ? 'E-mail inválido' : null;
      }
      case 'date': {
        return getData(value) == null ? 'Data inválida' : null;
      }
      case 'phone': {
        return !isPhone(value) ? 'Telefone inválido' : null;
      }
    }
    return null;
  }

  DateTime getData(String str) {
    try {
      return DateFormat('dd/MM/yyyy').parse(str);
    } catch (e) {
      return null;
    }
  }

  bool isPhone(value) {
    return matches(value, r"^(\([0-9]{2}\))\s([9]{1})?([0-9]{4})-([0-9]{4})");
  }
}
