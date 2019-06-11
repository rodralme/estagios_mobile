class Vaga {
  final int id;
  final String data;
  final String dataFormatada;
  final String titulo;
  final String descricao;
  final String inicio;
  final String fim;
  final String area;
  final String sigla;
  final String empresa;
  final String remuneracao;
  final String cargaHoraria;
  final String email;
  final String telefone;
  final bool candidatado;
  final String banner;

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

  String periodo() {
    return "Período: $inicio a $fim";
  }

  @override
  String toString() {
    return "$sigla - $titulo";
  }
}