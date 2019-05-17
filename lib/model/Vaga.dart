class Vaga {
  final int id;
  final bool ativo;
  final String titulo;
  final String descricao;
  final String remuneracao;
  final String cargaHoraria;
  final String empresa;
  final String areas;

  Vaga({
    this.id,
    this.ativo,
    this.titulo,
    this.descricao,
    this.remuneracao,
    this.cargaHoraria,
    this.empresa,
    this.areas,
  });

  factory Vaga.fromJson(Map<String, dynamic> json) {
    return Vaga(
      id: json['id'],
      ativo: json['ativo'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      remuneracao: json['remuneracao'],
      cargaHoraria: json['carga_horaria'],
      empresa: json['empresa'],
      areas: json['areas'],
    );
  }

  @override
  String toString() {
    return "$empresa - $titulo";
  }
}