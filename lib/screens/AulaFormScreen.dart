// screens/aula_form_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/aula.dart';

class AulaFormScreen extends StatefulWidget {
  const AulaFormScreen({super.key});

  @override
  _AulaFormScreenState createState() => _AulaFormScreenState();
}

class _AulaFormScreenState extends State<AulaFormScreen> {
  final ApiService apiService = ApiService();
  final _tituloController = TextEditingController();

  void _submitForm() async {
    try {
      final aula = Aula(
        id: 0,
        titulo: _tituloController.text,
        data: DateTime.now(),
        professorId: 1,
      );
      await apiService.addAula(aula);
      Navigator.pop(context, true);
    } catch (e) {
      print('Erro ao adicionar aula: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Aula")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: "Título da Aula"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
