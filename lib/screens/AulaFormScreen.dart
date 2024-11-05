// screens/aula_form_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/aula.dart';

class AulaFormScreen extends StatefulWidget {
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
      appBar: AppBar(title: Text("Adicionar Aula")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: "Título da Aula"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
