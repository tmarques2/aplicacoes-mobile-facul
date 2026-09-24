import 'package:flutter/material.dart';
import 'package:hospedagem/data/cart_provider.dart';
import 'package:hospedagem/data/session_storage.dart';
import 'package:hospedagem/ui/widget/login/login_screen.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:hospedagem/ui/widget/checkout/checkout_screen.dart';
import 'package:hospedagem/ui/widget/home/widget/destination_carousel.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _logout(BuildContext context) async {
    await SessionStorage.logout();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
      (route) => false,
    );
  }

  void _openCart(BuildContext context) {
    if (context.read<CartProvider>().total == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seu carrinho está vazio.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S&M Hotel'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        actions: [
          IconButton(
            onPressed: () => _openCart(context),
            tooltip: 'Carrinho',
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () => _logout(context),
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const DestinationCarousel(),
    );
  }
}

class HomeScreen extends Home {
  const HomeScreen({super.key});
}
