import 'dart:io';

import 'package:estagios/components/campo_data.dart';
import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/components/loading.dart';
import 'package:estagios/model/Area.dart';
import 'package:estagios/model/Vaga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';

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
  final _telefone = MaskedTextController(mask: "(00) 0000-0000");

  @override
  void initState() {
    popularDropdownArea();
    super.initState();

    _telefone.beforeChange = (String previous, String next) {
      if (next.length >= 15) {
        _telefone.updateMask("(00) 00000-0000");
      } else {
        _telefone.updateMask("(00) 0000-0000");
      }
      return true;
    };
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Enviar imagem'),
                    onPressed: () {
                      upload(context);
                    },
                  ),
                ],
              ),
              CampoTexto(
                controller: _titulo,
                label: 'Título',
                rules: 'required',
                onSaved: (val) => vaga.titulo = val,
              ),
              CampoTexto(
                controller: _descricao,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
                validator: (value) {
                  return value == null ? 'Campo obrigatório' : null;
                },
              ),
              CampoTexto(
                label: 'Empresa',
                rules: 'required',
                onSaved: (val) => vaga.empresa = val,
              ),
              CampoTexto(
                controller: _email,
                label: 'E-mail',
                rules: 'required|email',
                onSaved: (val) => vaga.email = val,
              ),
              CampoTexto(
                controller: _telefone,
                keyboardType: TextInputType.phone,
                label: 'Telefone',
                rules: 'required|phone',
                onSaved: (val) => vaga.telefone = val,
              ),
              CampoData(
                controller: _inicio,
                label: 'Início',
                required: true,
                onSaved: (val) => vaga.inicio = val,
              ),
              CampoData(
                controller: _fim,
                label: 'Fim',
                required: true,
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

  void upload(BuildContext context) async {
    setState(() => _loading = true);

    try {
      var source = ImageSource.gallery;
//      var source = ImageSource.camera;

      File file = await ImagePicker.pickImage(source: source);

      var connection = new Connection();
      var data = await connection.upload(file);

      vaga.banner = data['image_key']['url'];

    } catch (e) {
      print(e);
    } finally {
      setState(() => _loading = false);
    }
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
