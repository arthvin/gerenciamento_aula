// test/api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gerenciamento_aula/services/api_service.dart';
import 'package:gerenciamento_aula/models/aula.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('ApiService Tests', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    test('deve filtrar aulas pelo título', () async {
      final aulas = [
        Aula(id: 1, titulo: 'Matemática', data: DateTime.now()),
        Aula(id: 2, titulo: 'Física', data: DateTime.now()),
        Aula(id: 3, titulo: 'Matemática Avançada', data: DateTime.now()),
      ];

      when(mockApiService.getAulas()).thenAnswer((_) async => aulas);

      final result = await mockApiService.getAulas();
      final filteredAulas =
          result.where((aula) => aula.titulo.contains('Matemática')).toList();

      expect(filteredAulas.length, 2);
      expect(filteredAulas[0].titulo, 'Matemática');
      expect(filteredAulas[1].titulo, 'Matemática Avançada');
    });
  });
}
