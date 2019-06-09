class ItemVaga {
  final int id;
  final String data;
  final String titulo;
  final String descricao;
  final String inicio;
  final String fim;
  final String area;
  final String sigla;
  final String remuneracao;
  final String cargaHoraria;
  final String email;
  final String telefone;

  ItemVaga({
    this.id,
    this.data,
    this.titulo,
    this.descricao,
    this.inicio,
    this.fim,
    this.area,
    this.sigla,
    this.remuneracao,
    this.cargaHoraria,
    this.email,
    this.telefone,
  });

  factory ItemVaga.fromJson(Map<String, dynamic> json) {
    return ItemVaga(
      id: json['id'],
      data: json['data'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      inicio: json['inicio'],
      fim: json['fim'],
      area: json['area'],
      sigla: json['sigla'],
      remuneracao: json['remuneracao'] ?? '<não informado>',
      cargaHoraria: json['carga_horaria'] ?? '<não informado>',
      email: json['email'] ?? '<não informado>',
      telefone: json['telefone'] ?? '<não informado>',
    );
  }

  String descricaoFormatada() {
    return this.descricao.length > 150
        ? this.descricao.substring(0, 147) + ' ...'
        : this.descricao;
  }

  @override
  String toString() {
    return "$sigla - $titulo";
  }
}
