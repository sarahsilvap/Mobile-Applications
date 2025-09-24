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
      appBar: AppBar(
        title: const Text("Destinos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Checkout geral
              Navigator.pushNamed(context, '/checkout');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout -> volta para login
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
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
                  leading: Image.asset(
                    destino.image,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(destino.name),
                  subtitle: Text(
                      "Diária: R\$${destino.valord.toStringAsFixed(2)} | Por pessoa: R\$${destino.valorp.toStringAsFixed(2)}"),
                  trailing: ElevatedButton(
                    child: const Text("Comprar"),
                    onPressed: () {
                      // Passa destino selecionado para Checkout
                      Navigator.pushNamed(
                        context,
                        '/checkout',
                        arguments: destino,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
