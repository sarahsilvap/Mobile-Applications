import 'package:flutter/material.dart';
import '../models/Destination.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Destination>> _futureDestinos;

  @override
  void initState() {
    super.initState();
    _futureDestinos = ApiService.getDestinos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Destinos")),
      body: FutureBuilder<List<Destination>>(
        future: _futureDestinos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum destino encontrado."));
          }

          final destinos = snapshot.data!;

          return ListView.builder(
            itemCount: destinos.length,
            itemBuilder: (context, index) {
              final destino = destinos[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.asset(destino.image, width: 60, fit: BoxFit.cover),
                  title: Text(destino.name),
                  subtitle: Text(
                      "Diária: R\$${destino.valord.toStringAsFixed(2)} | Passeio: R\$${destino.valorp.toStringAsFixed(2)}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
