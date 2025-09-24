import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class Destino extends StatefulWidget {
  final String nome;
  final String imagePath;
  final int valord;
  final int valorp;

  const Destino({
    super.key,
    required this.nome,
    required this.imagePath,
    required this.valord,
    required this.valorp,
  });

  @override
  State<Destino> createState() => _DestinoState();
}

class _DestinoState extends State<Destino> {
  int nDiarias = 0;
  int nPessoas = 0;

  void incrementarDiarias() {
    setState(() {
      nDiarias++;
    });
  }

  void incrementarPessoas() {
    setState(() {
      nPessoas++;
    });
  }

  void calcularTotal() {
    Provider.of<CartProvider>(context, listen: false).calcularTotal(
      nDiarias: nDiarias,
      valord: widget.valord,
      nPessoas: nPessoas,
      valorp: widget.valorp,
    );
  }

  void limparCampos() {
    setState(() {
      nDiarias = 0;
      nPessoas = 0;
    });
    Provider.of<CartProvider>(context, listen: false).limpar();
  }

  @override
  Widget build(BuildContext context) {
    int total = Provider.of<CartProvider>(context).total;

    return Container(
      width: 393,
      height: 250,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(widget.nome, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Número de diárias
                    Row(
                      children: [
                        const Text("Diárias: ", style: TextStyle(color: Colors.white)),
                        Text("$nDiarias", style: const TextStyle(color: Colors.white)),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: incrementarDiarias,
                        ),
                      ],
                    ),
                    // Número de pessoas
                    Row(
                      children: [
                        const Text("Pessoas: ", style: TextStyle(color: Colors.white)),
                        Text("$nPessoas", style: const TextStyle(color: Colors.white)),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: incrementarPessoas,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: calcularTotal,
                      child: const Text("Calcular"),
                    ),
                    ElevatedButton(
                      onPressed: limparCampos,
                      child: const Text("Limpar"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    ),
                    Text("Total: R\$ $total", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
