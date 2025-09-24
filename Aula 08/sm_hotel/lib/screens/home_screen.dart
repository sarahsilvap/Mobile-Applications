import 'package:flutter/material.dart';
import '../models/Destination.dart';
import '../services/api_service.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text("S&M Hotel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
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
              return Destino(
                nome: destino.name,
                imagePath: destino.image,
                valord: destino.valord.toInt(),
                valorp: destino.valorp.toInt(),
              );
            },
          );
        },
      ),
    );
  }
}
