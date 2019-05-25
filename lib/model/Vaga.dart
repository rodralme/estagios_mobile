

class Vaga {

  final int id;
  final bool ativo;
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

  Vaga({
    this.id,
    this.ativo,
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
  });

  factory Vaga.fromJson(Map<String, dynamic> json) {
    return Vaga(
      id: json['id'],
      ativo: json['ativo'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      inicio: json['inicio'],
      fim: json['fim'],
      area: json['area'],
      sigla: json['sigla'],
      empresa: json['empresa'] ?? '<não informado>',
      remuneracao: json['remuneracao'] ?? '<não informado>',
      cargaHoraria: json['carga_horaria'] ?? '<não informado>',
      email: json['email'] ?? '<não informado>',
      telefone: json['telefone'] ?? '<não informado>',
    );
  }

  String tituloFormatado() {
    return this.titulo.length > 50 ? this.titulo.substring(0, 47) + '...' : this.titulo;
  }

  String descricaoFormatada() {
    return this.descricao.length > 150 ? this.descricao.substring(0, 147) + '...' : this.descricao;
  }

  @override
  String toString() {
    return "$sigla - $titulo";
  }
}