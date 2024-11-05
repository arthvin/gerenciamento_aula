// test/aula_detalhes_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_aula/screens/auladetalhesscreen.dart';
import 'package:gerenciamento_aula/models/aula.dart';

void main() {
  testWidgets('AulaDetalhesScreen exibe detalhes da aula',
      (WidgetTester tester) async {
    // Criação de um objeto Aula
    final aula = Aula(id: 1, titulo: 'Matemática', data: DateTime(2024, 11, 5));

    // Carregar a tela
    await tester.pumpWidget(MaterialApp(home: AulaDetalhesScreen(aula: aula)));

    // Verificar se os detalhes estão sendo exibidos corretamente
    expect(find.text('Detalhes da Aula'), findsOneWidget);
    expect(find.text('Título:'), findsOneWidget);
    expect(find.text('Matemática'), findsOneWidget);
    expect(find.text('Data:'), findsOneWidget);
    expect(find.text('05/11/2024'), findsOneWidget);

    // Verificar se os botões de editar e excluir estão presentes
    expect(find.text('Editar'), findsOneWidget);
    expect(find.text('Excluir'), findsOneWidget);
  });
}
