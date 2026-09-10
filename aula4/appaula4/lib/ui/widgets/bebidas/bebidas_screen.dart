import 'package:appaula4/model/dish.dart';
import 'package:appaula4/ui/_core/app_colors.dart';
import 'package:appaula4/ui/_core/appbar.dart';
import 'package:appaula4/ui/widgets/bag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BebidasScreen extends StatelessWidget {
  const BebidasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Criando uma lista de bebidas fictícias usando o modelo Dish existente
    List<Dish> bebidas = [
      Dish(
          id: 'bebida-1',
          imagePath: 'dishes/default.png',
          name: 'Coca Cola',
          description: 'Refrigerante 350ml',
          price: 8),
      Dish(
          id: 'bebida-2',
          imagePath: 'dishes/default.png',
          name: 'Suco de Laranja',
          description: 'Suco Natural 500ml',
          price: 12),
      Dish(
          id: 'bebida-3',
          imagePath: 'dishes/default.png',
          name: 'Água Mineral',
          description: 'Água sem gás 500ml',
          price: 5),
      Dish(
          id: 'bebida-4',
          imagePath: 'dishes/default.png',
          name: 'Cerveja Artesanal',
          description: 'Garrafa 600ml',
          price: 18),
    ];

    return Scaffold(
      appBar: getAppBar(context: context, title: 'Bebidas'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/categories/bebidas.png',
              width: 128,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Mais pedidos',
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: List.generate(bebidas.length, (index) {
                Dish dish = bebidas[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/dishes/default.png',
                    width: 48,
                    height: 48,
                  ),
                  title: Text(dish.name),
                  subtitle: Text('R\$${dish.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                      onPressed: () {
                        context.read<BagProvider>().addAllDishes([dish]);
                      },
                      icon: Icon(Icons.add)),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
