import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hospedagem/data/destinations_data.dart';
import 'package:hospedagem/model/destination.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:hospedagem/ui/widget/destino/destino_screen.dart';

class DestinationCarousel extends StatefulWidget {
  const DestinationCarousel({super.key});

  @override
  State<DestinationCarousel> createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  Timer? _autoAdvanceTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _autoAdvanceTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => _showNextDestination(),
    );
  }

  void _showNextDestination() {
    if (!_pageController.hasClients) return;
    final nextPage = (_currentPage + 1) % destinations.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _openDetails(Destination destination) {
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
            itemCount: destinations.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) {
              final destination = destinations[index];
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
              destinations.length,
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
