import 'package:appaula4/ui/_core/app_colors.dart';
import 'package:appaula4/ui/widgets/categorias/bebidas_screen.dart';
import 'package:appaula4/ui/widgets/categorias/petiscos_screen.dart';
import 'package:appaula4/ui/widgets/categorias/principais_screen.dart';
import 'package:appaula4/ui/widgets/categorias/massas_screen.dart';
import 'package:appaula4/ui/widgets/categorias/sobremesas_screen.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Widget screen;
        switch (category) {
          case 'Bebidas':
            screen = const BebidasScreen();
            break;
          case 'Petiscos':
            screen = const PetiscosScreen();
            break;
          case 'Principais':
            screen = const PrincipaisScreen();
            break;
          case 'Massas':
            screen = const MassasScreen();
            break;
          case 'Sobremesas':
            screen = const SobremesasScreen();
            break;
          default:
            return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return screen;
        }));
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: AppColors.lightBackgroundColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/categories/${category.toLowerCase()}.png',
              height: 48,
            ),
            Text(
              category,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
