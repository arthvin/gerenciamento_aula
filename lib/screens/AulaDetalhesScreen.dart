import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/aula.dart';
import '../services/api_service.dart';

class AulaDetalhesScreen extends StatelessWidget {
  final Aula aula;
  final ApiService apiService = ApiService();

  AulaDetalhesScreen({required this.aula});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Aula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(aula.titulo, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(DateFormat('dd/MM/yyyy').format(aula.data.toLocal())),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implementar a lógica de edição (ex: abrir um formulário para editar)
                  },
                  child: Text('Editar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await apiService.deleteAula(aula.id);
                    Navigator.pop(context); // Voltar à lista após a exclusão
                  },
                  child: Text('Excluir'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red), // Alterado para backgroundColor
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
