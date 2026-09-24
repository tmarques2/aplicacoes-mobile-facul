import 'package:flutter/foundation.dart';
import 'package:hospedagem/model/destination.dart';
import 'package:hospedagem/model/reservation.dart';

class CartProvider extends ChangeNotifier {
  Reservation? reservation;
  String destino = '';
  String imagem = '';
  int diarias = 0;
  int acompanhantes = 0;
  int valorDiaria = 0;
  int valorPessoa = 0;
  int total = 0;

  int calcularTotal({
    required Destination destination,
    required int nDiarias,
    required int valorDiaria,
    required int nPessoas,
    required int valorPessoa,
  }) {
    final valorTotal = (nDiarias * valorDiaria) + (nPessoas * valorPessoa);
    reservation = Reservation(
      destination: destination,
      days: nDiarias,
      companions: nPessoas,
      total: valorTotal,
    );
    destino = destination.name;
    imagem = destination.image;
    diarias = nDiarias;
    acompanhantes = nPessoas;
    this.valorDiaria = valorDiaria;
    this.valorPessoa = valorPessoa;
    total = valorTotal;
    notifyListeners();
    return total;
  }

  void limpar() {
    reservation = null;
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
