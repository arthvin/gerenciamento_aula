class Aula {
  final int id;
  final String titulo;
  final DateTime data;
  final int professorId;

  Aula({
    required this.id,
    required this.titulo,
    required this.data,
    required this.professorId,
  });

  factory Aula.fromJson(Map<String, dynamic> json) {
    return Aula(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      titulo: json['titulo'],
      data: DateTime.parse(json['data']),
      professorId: json['professorId'] is String
          ? int.parse(json['professorId'])
          : json['professorId'],
    );
  }

  Aula copyWith({
    int? id,
    String? titulo,
    DateTime? data,
    int? professorId,
  }) {
    return Aula(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      data: data ?? this.data,
      professorId: professorId ?? this.professorId,
    );
  }

  @override
  String toString() {
    return 'Aula(id: $id, titulo: $titulo, data: $data, professorId: $professorId)';
  }
}
