import 'package:appaula4/data/restaurant_data.dart';
import 'package:appaula4/ui/_core/app_theme.dart';
import 'package:appaula4/ui/widgets/bag_provider.dart';
import 'package:appaula4/ui/widgets/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Serve para carregar a tela do app sem ficar esperando o provider ou banco de dados
  RestaurantData restaurantData = RestaurantData();
  await restaurantData.getRestaurant();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) {
        return restaurantData;
      }),
      ChangeNotifierProvider(create: (context) => BagProvider())
    ],
    child: AppDelivery(),
  ));
}

class AppDelivery extends StatelessWidget {
  const AppDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: SplashScreen(),
    );
  }
}
