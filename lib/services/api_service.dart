import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aula.dart';
import '../models/professor.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Aula>> fetchAulas() async {
    try {
      print('Fetching data from $baseUrl/aulas');
      final response = await http.get(Uri.parse('$baseUrl/aulas'));
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          List<dynamic> data = json.decode(response.body);
          print('Data received: $data');

          // Verificação adicional para assegurar que os dados estão no formato esperado
          return data.map((item) {
            try {
              return Aula.fromJson(item);
            } catch (e) {
              print('Erro ao converter item para Aula: $item, erro: $e');
              throw Exception('Erro ao processar item no formato Aula');
            }
          }).toList();
        } else {
          throw Exception('Resposta não é um JSON');
        }
      } else {
        throw Exception(
            'Erro ao buscar dados, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
      throw Exception('Erro ao buscar dados: $e');
    }
  }

  Future<List<Professor>> fetchProfessores() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/professores'));
      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          List<dynamic> data = json.decode(response.body);
          return data.map((json) => Professor.fromJson(json)).toList();
        } else {
          throw Exception('Resposta não é um JSON');
        }
      } else {
        throw Exception(
            'Erro ao carregar professores, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar professores: $e');
      throw Exception('Erro ao carregar professores: $e');
    }
  }

  Future<void> deleteAula(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/aulas/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao excluir a aula');
    }
  }

  Future<void> atualizarAula(Aula aula) async {
    final response = await http.put(
      Uri.parse('$baseUrl/aulas/${aula.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'titulo': aula.titulo,
        'data': aula.data.toIso8601String(),
        'professorId': aula.professorId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar aula: ${response.body}');
    }
  }

  Future<void> addAula(Aula aula) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/aulas'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Gerar um novo ID de forma mais robusta
        int newId;
        if (data.isNotEmpty) {
          int lastId = data
              .map((item) => item['id'] as int)
              .reduce((a, b) => a > b ? a : b);
          newId = lastId + 1;
        } else {
          newId = 1;
        }

        final postResponse = await http.post(
          Uri.parse('$baseUrl/aulas'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'id': newId,
            'titulo': aula.titulo,
            'data': aula.data.toIso8601String(),
            'professorId': aula.professorId,
          }),
        );

        if (postResponse.statusCode != 201) {
          throw Exception('Erro ao adicionar aula: ${postResponse.body}');
        }
      } else {
        throw Exception('Erro ao buscar último ID: ${response.body}');
      }
    } catch (e) {
      print('Erro ao adicionar aula: $e');
      throw Exception('Erro ao adicionar aula: $e');
    }
  }
}
