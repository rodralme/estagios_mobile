import 'package:estagios/components/campo_texto.dart';
import 'package:estagios/components/default_app_bar.dart';
import 'package:estagios/connection.dart';
import 'package:estagios/model/Pessoa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final Pessoa pessoa;

  ProfilePage({Key key, @required this.pessoa}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  var _loading = false;

  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _nascimento = MaskedTextController(mask: "00/00/0000");
  final _telefone = MaskedTextController(mask: "(00) 0000-0000");
  final _sobre = TextEditingController();

  @override
  void initState() {
    super.initState();

    final pessoa = this.widget.pessoa;

    _nome.text = pessoa.nome;
    _email.text = pessoa.email;
    _nascimento.text = pessoa.nascimento;
    _telefone.text = pessoa.telefone1;
    _sobre.text = pessoa.sobre;

    _telefone.beforeChange = (String previous, String next) {
      if (next.length >= 15) {
        _telefone.updateMask("(00) 00000-0000");
      } else {
        _telefone.updateMask("(00) 0000-0000");
      }
      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: DefaultAppBar(
          "Perfil",
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Meus Dados',
              ),
              Tab(
                icon: Icon(Icons.wallpaper),
                text: 'Anúncios',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            CampoTexto(
                              controller: _nome,
                              label: 'Nome',
                              rules: 'required',
                            ),
                            CampoTexto(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              label: 'E-mail',
                              rules: 'email',
                            ),
                            CampoTexto(
                              controller: _nascimento,
                              keyboardType: TextInputType.datetime,
                              label: 'Nascimento',
                              rules: 'data',
                            ),
                            CampoTexto(
                              controller: _telefone,
                              keyboardType: TextInputType.phone,
                              label: "Telefone",
                              rules: 'phone',
                            ),
                            CampoTexto(
                              controller: _sobre,
                              label: 'Sobre',
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              children: <Widget>[
                                RaisedButton(
                                  child: Text(
                                    'Salvar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_loading) return;
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    if (formKey.currentState.validate()) {
                                      salvar(context);
                                    }
                                  },
                                ),
                                SizedBox(width: 10.0),
                                RaisedButton(
                                  child: Text(
                                    'Deslogar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  color: Colors.red[700],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_loading) return;
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    deslogar(context);
                                  },
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text('teste'),
          ],
        ),
      ),
    );
  }

  DateTime getData(String str) {
    try {
      return DateFormat('dd/MM/yyyy').parse(str);
    } catch (e) {
      return null;
    }
  }

  void salvar(BuildContext context) async {
    setState(() => _loading = true);

    var params = {
      'nome': this._nome.text,
      'email': this._email.text,
      'nascimento':
          DateFormat('yyy-MM-dd').format(getData(this._nascimento.text)),
      'telefone1': this._telefone.text,
      'sobre': this._sobre.text,
    };

    var data;
    try {
      var connection = new Connection();
      data = await connection.put("pessoas/${this.widget.pessoa.id}", params);
    } finally {
      setState(() => _loading = false);
    }

    if (data['success']) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text("Perfil salvo com sucesso!"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
  }

  void deslogar(context) async {
    setState(() => _loading = true);

    var connection = new Connection();
    var data = await connection.post('logout');

    setState(() => _loading = false);

    if (data['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
    }
    Navigator.pushReplacementNamed(context, '/login');
  }
}
