import 'package:flutter/material.dart';
import 'package:hospedagem/data/cart_provider.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'Cartão';

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void _finishPurchase() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reserva confirmada'),
        content: const Text(
          'Sua viagem foi adicionada com sucesso. Aproveite o destino!',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              context.read<CartProvider>().limpar();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Concluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final subtotal = cart.total.toDouble();
    final double discount = _paymentMethod == 'Pix' ? subtotal * 0.1 : 0.0;
    final double finalTotal = subtotal - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  cart.imagem,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.destino,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 14),
                      _SummaryRow(
                        label: 'Diárias',
                        value: '${cart.diarias}',
                      ),
                      _SummaryRow(
                        label: 'Acompanhantes',
                        value: '${cart.acompanhantes}',
                      ),
                      _SummaryRow(
                        label: 'Subtotal',
                        value: _formatCurrency(subtotal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Forma de pagamento',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          RadioListTile<String>(
            value: 'Pix',
            groupValue: _paymentMethod,
            onChanged: (value) => setState(() => _paymentMethod = value!),
            title: const Text('Pix'),
            subtitle: const Text('10% de desconto'),
            activeColor: AppColors.primary,
          ),
          RadioListTile<String>(
            value: 'Cartão',
            groupValue: _paymentMethod,
            onChanged: (value) => setState(() => _paymentMethod = value!),
            title: const Text('Cartão'),
            activeColor: AppColors.primary,
          ),
          const Divider(height: 28),
          if (discount > 0)
            _SummaryRow(
              label: 'Desconto Pix',
              value: '- ${_formatCurrency(discount)}',
              valueColor: AppColors.primary,
            ),
          _SummaryRow(
            label: 'Total da viagem',
            value: _formatCurrency(finalTotal),
            emphasis: true,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: cart.total > 0 ? _finishPurchase : null,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirmar reserva'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasis = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool emphasis;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: valueColor ?? (emphasis ? AppColors.primaryDark : AppColors.text),
      fontSize: emphasis ? 18 : 15,
      fontWeight: emphasis ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value, style: style)],
      ),
    );
  }
}
