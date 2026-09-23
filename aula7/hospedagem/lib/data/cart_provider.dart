import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  int total = 0;

  int calcularTotal({
    required int nDiarias,
    required int valorDiaria,
    required int nPessoas,
    required int valorPessoa,
  }) {
    total = (nDiarias * valorDiaria) + (nPessoas * valorPessoa);
    notifyListeners();
    return total;
  }

  void limpar() {
    total = 0;
    notifyListeners();
  }
}
