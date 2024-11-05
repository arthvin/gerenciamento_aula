class Professor {
  final int id;
  final String nome;
  final String departamento;

  Professor({required this.id, required this.nome, required this.departamento});

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      id: json['id'],
      nome: json['nome'],
      departamento: json['departamento'],
    );
  }
}
