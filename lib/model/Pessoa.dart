class Pessoa {
  final int id;
  final bool ativo;
  final String nome;
  final String email;
  final String nascimento;
  final String telefone1;
  final String telefone2;
  final String sobre;

  Pessoa({
    this.id,
    this.ativo,
    this.nome,
    this.email,
    this.nascimento,
    this.telefone1,
    this.telefone2,
    this.sobre,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['id'],
      ativo: json['ativo'],
      nome: json['nome'],
      email: json['email'],
      nascimento: json['nascimento'],
      telefone1: json['telefone1'],
      telefone2: json['telefone2'],
    );
  }
}