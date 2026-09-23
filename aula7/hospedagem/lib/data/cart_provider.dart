import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  String destino = '';
  String imagem = '';
  int diarias = 0;
  int acompanhantes = 0;
  int valorDiaria = 0;
  int valorPessoa = 0;
  int total = 0;

  int calcularTotal({
    required int nDiarias,
    required int valorDiaria,
    required int nPessoas,
    required int valorPessoa,
    String nomeDestino = '',
    String caminhoImagem = '',
  }) {
    destino = nomeDestino;
    imagem = caminhoImagem;
    diarias = nDiarias;
    acompanhantes = nPessoas;
    this.valorDiaria = valorDiaria;
    this.valorPessoa = valorPessoa;
    total = (nDiarias * valorDiaria) + (nPessoas * valorPessoa);
    notifyListeners();
    return total;
  }

  void limpar() {
    destino = '';
    imagem = '';
    diarias = 0;
    acompanhantes = 0;
    valorDiaria = 0;
    valorPessoa = 0;
    total = 0;
    notifyListeners();
  }
}
