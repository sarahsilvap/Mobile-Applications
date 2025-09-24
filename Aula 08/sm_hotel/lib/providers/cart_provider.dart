import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  int total = 0;

  void calcularTotal({required int nDiarias, required int valord, required int nPessoas, required int valorp}) {
    total = (nDiarias * valord) + (nPessoas * valorp);
    notifyListeners();
  }

  void limpar() {
    total = 0;
    notifyListeners();
  }
}
