import 'package:flutter/material.dart';
import 'package:hospedagem/data/cart_provider.dart';
import 'package:hospedagem/ui/widget/login/login_screen.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            surface: AppColors.surface,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
          ),
        ),
        home: Login(),
      ),
    ),
  );
}
