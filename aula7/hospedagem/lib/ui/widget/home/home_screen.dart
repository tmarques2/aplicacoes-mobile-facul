import 'package:flutter/material.dart';
import 'package:hospedagem/data/cart_provider.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S&M Hotel'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: const _DestinationCarousel(),
    );
  }
}

class HomeScreen extends Home {
  const HomeScreen({super.key});
}

class _Destination {
  const _Destination({
    required this.name,
    required this.image,
    required this.dailyRate,
    required this.guestRate,
  });

  final String name;
  final String image;
  final int dailyRate;
  final int guestRate;
}

const _destinations = [
  _Destination(
    name: 'Angra dos Reis',
    image: 'assets/angra.jpg',
    dailyRate: 384,
    guestRate: 70,
  ),
  _Destination(
    name: 'Jericoacoara',
    image: 'assets/jericoacoara.jpg',
    dailyRate: 571,
    guestRate: 75,
  ),
  _Destination(
    name: 'Arraial do Cabo',
    image: 'assets/arraial.jpg',
    dailyRate: 534,
    guestRate: 65,
  ),
  _Destination(
    name: 'Florianópolis',
    image: 'assets/floripa.jpg',
    dailyRate: 348,
    guestRate: 85,
  ),
  _Destination(
    name: 'Madri',
    image: 'assets/madri.jpg',
    dailyRate: 401,
    guestRate: 85,
  ),
  _Destination(
    name: 'Paris',
    image: 'assets/paris.jpg',
    dailyRate: 546,
    guestRate: 95,
  ),
  _Destination(
    name: 'Orlando',
    image: 'assets/orlando.jpg',
    dailyRate: 616,
    guestRate: 105,
  ),
  _Destination(
    name: 'Las Vegas',
    image: 'assets/lasvegas.jpg',
    dailyRate: 504,
    guestRate: 110,
  ),
  _Destination(
    name: 'Roma',
    image: 'assets/roma.jpg',
    dailyRate: 478,
    guestRate: 85,
  ),
  _Destination(
    name: 'Chile',
    image: 'assets/chile.jpg',
    dailyRate: 446,
    guestRate: 95,
  ),
];

class _DestinationCarousel extends StatefulWidget {
  const _DestinationCarousel();

  @override
  State<_DestinationCarousel> createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<_DestinationCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openDetails(_Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Destino(
          nomeDestino: destination.name,
          caminhoImagem: destination.image,
          valord: destination.dailyRate,
          valorp: destination.guestRate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 4),
          child: Text(
            'Escolha seu próximo destino',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child:
              Text('Toque em uma foto para ver valores e planejar sua viagem.'),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _destinations.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) {
              final destination = _destinations[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: GestureDetector(
                  onTap: () => _openDetails(destination),
                  child: Hero(
                    tag: destination.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(destination.image, fit: BoxFit.cover),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.primaryDark.withValues(alpha: 0.9),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      destination.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _destinations.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 7,
                width: index == _currentPage ? 24 : 7,
                decoration: BoxDecoration(
                  color: index == _currentPage
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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

  String _formatCurrency(int value) {
    return 'R\$ $value,00';
  }

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

  void calctotal() {
    final valorTotal = context.read<CartProvider>().calcularTotal(
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
              child: Image.asset(
                widget.caminhoImagem,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
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
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: dias,
                        icon: const Icon(Icons.add),
                        label: Text('Diárias: $n_diarias'),
                      ),
                      FilledButton.icon(
                        onPressed: incrementarPessoas,
                        icon: const Icon(Icons.person_add_alt_1),
                        label: Text('Acompanhantes: $n_pessoas'),
                      ),
                      FilledButton.icon(
                        onPressed: calctotal,
                        icon: const Icon(Icons.calculate_outlined),
                        label: const Text('Calcular'),
                      ),
                      IconButton.outlined(
                        onPressed: limpar,
                        tooltip: 'Limpar campos',
                        icon: const Icon(Icons.cleaning_services_outlined),
                      ),
                    ],
                  ),
                  if (total > 0) ...[
                    const SizedBox(height: 14),
                    Text(
                      'Total da viagem: ${_formatCurrency(total)}',
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
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
