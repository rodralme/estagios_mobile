import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:estagios/components/campo_data.dart';
import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/components/loading.dart';
import 'package:estagios/model/Area.dart';
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
  bool _loading = true;

  var areas = new List<DropdownMenuItem<dynamic>>();
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
  void initState() {
    popularDropdownArea();
    super.initState();
  }

  void popularDropdownArea() async {
    var conn = new Connection();
    var data = await conn.get('areas');

    for (var item in data) {
      Area area = Area.fromJson(item);
      areas.add(new DropdownMenuItem(
        value: area.id.toString(),
        child: new Text(area.nome),
      ));
    }

    setState(() => _loading = false);
  }

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
                items: areas,
                value: vaga.area,
                decoration: InputDecoration(
                  labelText: 'Área',
                ),
                onChanged: (value) {
                  setState(() => vaga.area = value.toString());
                },
                onSaved: (val) => vaga.area = val,
              ),
              CampoData(
                controller: _inicio,
                label: 'Início',
                onSaved: (val) {
                  print(val);
                  vaga.inicio = val;
                }
              ),
              CampoData(
                controller: _fim,
                label: 'Fim',
                onSaved: (val) => vaga.fim = val,
              ),
              CampoTexto(
                controller: _remuneracao,
                label: 'Remuneração',
                onSaved: (val) => vaga.remuneracao = val,
              ),
              CampoTexto(
                controller: _cargaHoraria,
                label: 'Carga Horária',
                onSaved: (val) => vaga.cargaHoraria = val,
              ),
              CampoTexto(
                controller: _email,
                label: 'E-mail',
                rules: 'required|email',
                onSaved: (val) => vaga.email = val,
              ),
              CampoTexto(
                controller: _telefone,
                label: 'Telefone',
                rules: 'required',
                onSaved: (val) => vaga.telefone = val,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Salvar'),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    salvar(context);
                  }
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

      var map = vaga.toMap();
      var data = await connection.post("vagas", map);

      if (data['success']) {
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('Vaga criada com sucesso'),
//          behavior: SnackBarBehavior.floating,
//        ));

        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => _loading = false);
    }
  }
}
