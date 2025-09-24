import 'package:flutter/material.dart';

class CartItem {
  final String nome;
  final String imagePath;
  final int valord;
  final int valorp;
  final int nDiarias;
  final int nPessoas;
  final int total;

  CartItem({
    required this.nome,
    required this.imagePath,
    required this.valord,
    required this.valorp,
    required this.nDiarias,
    required this.nPessoas,
  }) : total = (valord * nDiarias) + (valorp * nPessoas);
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void adicionarItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void limparCarrinho() {
    _items.clear();
    notifyListeners();
  }

  int get totalAcumulado {
    int total = 0;
    for (var item in _items) {
      total += item.total;
    }
    return total;
  }
}
