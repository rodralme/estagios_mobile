import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:estagios/components/campo_data.dart';
import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroVagaPage extends StatefulWidget {
  @override
  _CadastroVagaPageState createState() => _CadastroVagaPageState();
}

class _CadastroVagaPageState extends State<CadastroVagaPage> {
  final formKey = GlobalKey<FormState>();
  bool _loading = false;

  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  final _area = TextEditingController();
  final _inicio = TextEditingController();
  final _fim = TextEditingController();
  final _remuneracao = TextEditingController();
  final _cargaHoraria = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (this._loading) {
      return Loading();
    }

    return Scaffold(
      appBar: DefaultAppBar("Cadastro de Vaga"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              CampoTexto(
                controller: _titulo,
                label: 'Título',
                rules: 'required',
              ),
              CampoTexto(
                controller: _descricao,
                label: 'Descrição',
                rules: 'required',
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Área',
                ),
                validator: ,
              ),
              CampoData(
                controller: _inicio,
                label: 'Início',
              ),
              CampoData(
                controller: _fim,
                label: 'Fim',
              ),
              CampoTexto(
                controller: _remuneracao,
                label: 'Remuneração',
                rules: 'required',
              ),
              CampoTexto(
                controller: _cargaHoraria,
                label: 'Carga Horária',
                rules: 'required',
              ),
              CampoTexto(
                controller: _email,
                label: 'E-mail',
                rules: 'email',
              ),
              CampoTexto(
                controller: _telefone,
                label: 'Telefone',
                rules: 'phone',
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Salvar'),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  formKey.currentState.validate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
