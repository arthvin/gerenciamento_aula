import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/aula.dart';
import '../services/api_service.dart';

class AulaDetalhesScreen extends StatefulWidget {
  final Aula aula;
  final ApiService apiService = ApiService();

  AulaDetalhesScreen({super.key, required this.aula});

  @override
  _AulaDetalhesScreenState createState() => _AulaDetalhesScreenState();
}

class _AulaDetalhesScreenState extends State<AulaDetalhesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _dataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tituloController.text = widget.aula.titulo;
    _dataController.text =
        DateFormat('dd/MM/yyyy').format(widget.aula.data.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Aula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Título:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Título da aula',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Data:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _dataController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Data da aula (dd/MM/yyyy)',
                  suffixIcon: Icon(Icons.lock,
                      color: Colors
                          .grey), // Ícone para indicar que é somente leitura
                ),
                enabled: false, // Torna o campo somente leitura
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Aula updatedAula = widget.aula.copyWith(
                          titulo: _tituloController.text,
                          data: DateFormat('dd/MM/yyyy')
                              .parse(_dataController.text),
                        );
                        widget.apiService.atualizarAula(updatedAula).then((_) {
                          Navigator.pop(context,
                              true); // Passa um valor para a tela anterior indicando que houve atualização
                        }).catchError((error) {
                          print('Erro ao atualizar aula: $error');
                        });
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print('Excluindo aula com id: ${widget.aula.id}');
                      await widget.apiService.deleteAula(widget.aula.id);
                      Navigator.pop(context,
                          true); // Passa um valor indicando que a aula foi excluída
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Excluir'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
