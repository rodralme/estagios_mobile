import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:estagios/components/campo_data.dart';
import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/components/loading.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../connection.dart';

class CadastroVagaPage extends StatefulWidget {
  @override
  _CadastroVagaPageState createState() => _CadastroVagaPageState();
}

class _CadastroVagaPageState extends State<CadastroVagaPage> {
  final formKey = GlobalKey<FormState>();
  bool _loading = false;

  Vaga vaga = new Vaga();

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
                onSaved: (val) => vaga.titulo = val,
              ),
              CampoTexto(
                controller: _descricao,
                label: 'Descrição',
                rules: 'required',
                onSaved: (val) => vaga.descricao = val,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Área',
                ),
                onSaved: (val) => vaga.area = val,
              ),
              CampoData(
                controller: _inicio,
                label: 'Início',
                onSaved: (val) => vaga.inicio = val,
              ),
              CampoData(
                controller: _fim,
                label: 'Fim',
                onSaved: (val) => vaga.fim = val,
              ),
              CampoTexto(
                controller: _remuneracao,
                label: 'Remuneração',
                rules: 'required',
                onSaved: (val) => vaga.remuneracao = val,
              ),
              CampoTexto(
                controller: _cargaHoraria,
                label: 'Carga Horária',
                rules: 'required',
                onSaved: (val) => vaga.cargaHoraria = val,
              ),
              CampoTexto(
                controller: _email,
                label: 'E-mail',
                rules: 'email',
                onSaved: (val) => vaga.email = val,
              ),
              CampoTexto(
                controller: _telefone,
                label: 'Telefone',
                rules: 'phone',
                onSaved: (val) => vaga.telefone = val,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Salvar'),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  formKey.currentState.validate();
                  salvar(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void salvar(BuildContext context) async {
    setState(() => _loading = true);

    try {
      var connection = new Connection();
      var data = await connection.post("vagas", vaga.toMap());

      if (data['success']) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Vaga criada com sucesso'),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => _loading = false);
    }
  }
}
