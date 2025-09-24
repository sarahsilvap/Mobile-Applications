import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Destination.dart';
import '../services/api_service.dart';
import '../widgets/destination_card.dart';
import '../providers/cart_provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("S&M Hotel"),
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

                // Substituímos o ListTile pelo widget Destino, que já contém os botões +, calcular e limpar
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
      ),
    );
  }
}
