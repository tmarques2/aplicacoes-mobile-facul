import 'package:appaula4/ui/_core/app_theme.dart';
import 'package:appaula4/ui/widgets/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.appTheme,
    home: SplashScreen(),
  ));
}
