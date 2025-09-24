import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        actions: [
          TextButton(
            onPressed: () {
              cartProvider.limparCarrinho();
            },
            child: const Text(
              "Limpar",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Viagens Selecionadas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Column(
              children: List.generate(
                cartProvider.items.length,
                (index) {
                  final item = cartProvider.items[index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        item.imagePath,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.nome),
                      subtitle: Text("${item.nDiarias} diárias, ${item.nPessoas} pessoas"),
                      trailing: Text("R\$ ${item.total}"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Total: R\$${cartProvider.totalAcumulado}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                cartProvider.limparCarrinho();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reserva confirmada!")),
                );
                Navigator.pop(context);
              },
              child: const Text(
                "Finalizar Reserva",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
