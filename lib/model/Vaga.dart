class Vaga {
  int id;
  String data;
  String dataFormatada;
  String titulo;
  String descricao;
  String inicio;
  String fim;
  String area;
  String sigla;
  String empresa;
  String remuneracao;
  String cargaHoraria;
  String email;
  String telefone;
  bool candidatado;
  String banner;

  Vaga({
    this.id,
    this.data,
    this.dataFormatada,
    this.titulo,
    this.descricao,
    this.inicio,
    this.fim,
    this.area,
    this.sigla,
    this.empresa,
    this.remuneracao,
    this.cargaHoraria,
    this.email,
    this.telefone,
    this.candidatado,
    this.banner,
  });

  factory Vaga.fromJson(Map<String, dynamic> json) {
    return Vaga(
      id: json['id'],
      data: json['data'],
      dataFormatada: json['data_fmt'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      inicio: json['inicio'],
      fim: json['fim'],
      area: json['area']['nome'],
      sigla: json['area']['sigla'],
      remuneracao: json['remuneracao'] ?? '<não informado>',
      cargaHoraria: json['carga_horaria'] ?? '<não informado>',
      email: json['email'] ?? '<não informado>',
      telefone: json['telefone'] ?? '<não informado>',
      candidatado: json['candidatado'] ?? false,
      banner: json['banner'] ?? '',
      empresa: json['empresa'] != null ? json['empresa']['nome'] : '<não informado>',
    );
  }

  Map toMap() {
    var data = new Map();
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['area'] = this.area;
    data['inicio'] = this.inicio;
    data['fim'] = this.fim;
    data['remuneracao'] = this.remuneracao;
    data['cargaHoraria'] = this.cargaHoraria;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    return data;
  }

  String periodo() {
    return "Período: $inicio a $fim";
  }

  @override
  String toString() {
    return "$sigla - $titulo";
  }
}