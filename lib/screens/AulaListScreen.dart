import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../models/aula.dart';
import 'auladetalhesscreen.dart';

class AulaListScreen extends StatefulWidget {
  const AulaListScreen({super.key});

  @override
  _AulaListScreenState createState() => _AulaListScreenState();
}

class _AulaListScreenState extends State<AulaListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Aula>> aulas;

  @override
  void initState() {
    super.initState();
    aulas = apiService.fetchAulas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Aula>>(
          future: aulas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Erro ao carregar aulas",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Nenhuma aula cadastrada",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Aula aula = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        aula.titulo,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Data: ${DateFormat('dd/MM/yyyy').format(aula.data.toLocal())}',
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.deepPurple,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AulaDetalhesScreen(aula: aula),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
