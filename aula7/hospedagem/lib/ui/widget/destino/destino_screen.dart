import 'package:flutter/material.dart';
import 'package:hospedagem/data/cart_provider.dart';
import 'package:hospedagem/model/destination.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:hospedagem/ui/widget/checkout/checkout_screen.dart';
import 'package:provider/provider.dart';

class Destino extends StatefulWidget {
  const Destino({
    super.key,
    required this.nomeDestino,
    required this.caminhoImagem,
    required this.valord,
    required this.valorp,
  });

  final String nomeDestino;
  final String caminhoImagem;
  final int valord;
  final int valorp;

  @override
  State<Destino> createState() => DestinoState();
}

class DestinoState extends State<Destino> {
  int total = 0;
  int n_diarias = 0;
  int n_pessoas = 0;

  String _formatCurrency(int value) => 'R\$ $value,00';

  void dias() {
    setState(() {
      n_diarias++;
      total = 0;
    });
  }

  void incrementarPessoas() {
    setState(() {
      n_pessoas++;
      total = 0;
    });
  }

  void diminuirDias() {
    if (n_diarias == 0) return;
    setState(() {
      n_diarias--;
      total = 0;
    });
  }

  void diminuirPessoas() {
    if (n_pessoas == 0) return;
    setState(() {
      n_pessoas--;
      total = 0;
    });
  }

  void calctotal() {
    final valorTotal = context.read<CartProvider>().calcularTotal(
          destination: Destination(
            name: widget.nomeDestino,
            image: widget.caminhoImagem,
            dailyRate: widget.valord,
            guestRate: widget.valorp,
          ),
          nDiarias: n_diarias,
          valorDiaria: widget.valord,
          nPessoas: n_pessoas,
          valorPessoa: widget.valorp,
        );
    setState(() => total = valorTotal);
  }

  void limpar() {
    setState(() {
      total = 0;
      n_diarias = 0;
      n_pessoas = 0;
    });
    context.read<CartProvider>().limpar();
  }

  @override
  Widget build(BuildContext context) {
    final pixTotal = (total * 0.9).round();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeDestino),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.caminhoImagem,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 393),
                height: 250,
                color: AppColors.surface,
                child: Image.asset(
                  widget.caminhoImagem,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nomeDestino,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Planeje sua estadia em ${widget.nomeDestino}.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _PriceInfo(
                          label: 'Diária',
                          value: _formatCurrency(widget.valord),
                        ),
                        _PriceInfo(
                          label: 'Por acompanhante',
                          value: _formatCurrency(widget.valorp),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _QuantityControl(
                          label: 'Diárias',
                          icon: Icons.hotel_outlined,
                          value: n_diarias,
                          onDecrease: diminuirDias,
                          onIncrease: dias,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _QuantityControl(
                          label: 'Acompanhantes',
                          icon: Icons.people_outline,
                          value: n_pessoas,
                          onDecrease: diminuirPessoas,
                          onIncrease: incrementarPessoas,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: calctotal,
                          icon: const Icon(Icons.calculate_outlined),
                          label: const Text('Calcular'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton.outlined(
                        onPressed: limpar,
                        tooltip: 'Limpar campos',
                        icon: const Icon(Icons.cleaning_services_outlined),
                      ),
                    ],
                  ),
                  if (total > 0) ...[
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total da viagem',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatCurrency(total),
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.pix,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'No Pix (10% de desconto): '
                                  '${_formatCurrency(pixTotal)}',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: const Text('Ir para checkout'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({
    required this.label,
    required this.icon,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String label;
  final IconData icon;
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onDecrease,
            tooltip: 'Diminuir $label',
            color: AppColors.onPrimary,
            icon: const Icon(Icons.remove),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.onPrimary, size: 16),
                Text(
                  '$label: $value',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onIncrease,
            tooltip: 'Aumentar $label',
            color: AppColors.onPrimary,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _PriceInfo extends StatelessWidget {
  const _PriceInfo({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
