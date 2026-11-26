import 'package:appaula12/services/api_service.dart';
import 'package:flutter/material.dart';

class ProdScreen extends StatefulWidget {
  final ApiService api;
  const ProdScreen({super.key, required this.api});

  @override
  State<ProdScreen> createState() => _ProdScreenState();
}

class _ProdScreenState extends State<ProdScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
