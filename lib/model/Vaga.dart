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
      empresa: json['empresa'] ?? '',
      candidatado: json['candidatado'] ?? false,
      banner: json['banner'] ?? '',
    );
  }

  Map toMap() {
    var data = new Map<String, String>();
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['area_atuacao_id'] = this.area;
    data['inicio'] = this.inicio;
    data['fim'] = this.fim;
    data['remuneracao'] = this.remuneracao;
    data['carga_horaria'] = this.cargaHoraria;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['empresa'] = this.empresa;
    data['banner'] = this.banner;
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