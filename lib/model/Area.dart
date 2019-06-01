class Area {
  final int id;
  final String sigla;
  final String nome;

  Area({
    this.id,
    this.sigla,
    this.nome,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      sigla: json['sigla'],
      nome: json['nome'],
    );
  }

  @override
  String toString() {
    return "$sigla - $nome";
  }
}