import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  // Lista de totais por destino
  List<int> _totais = [];

  // Retorna os totais
  List<int> get totais => _totais;

  // Adiciona um destino ao carrinho
  void adicionarTotal(int total) {
    _totais.add(total);
    notifyListeners();
  }

  // Limpa o carrinho
  void limparCarrinho() {
    _totais.clear();
    notifyListeners();
  }

  // Retorna o total acumulado
  int get totalAcumulado => _totais.fold(0, (prev, element) => prev + element);
}
