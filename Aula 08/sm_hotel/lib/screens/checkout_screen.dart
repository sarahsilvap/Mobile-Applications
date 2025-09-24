import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Resumo da Viagem", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text("Destino: Paris"),
                subtitle: const Text("5 noites, Hotel XYZ"),
                trailing: const Text("R\$ 3.500,00"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica de pagamento (futuramente)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reserva confirmada!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Finalizar Compra"),
            ),
          ],
        ),
      ),
    );
  }
}
