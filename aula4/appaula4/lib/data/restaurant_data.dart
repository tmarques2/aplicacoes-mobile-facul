// Cria a classe restaurant data

import 'package:appaula4/model/restaurant.dart';
import 'package:appaula4/model/dish.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class RestaurantData extends ChangeNotifier {
  // Cria uma lista para carregar os restaurantes

  final List<Restaurant> _listRestaurant = [];
  List<Restaurant> get listRestaurant => _listRestaurant;
  final List<Dish> _listBeverages = [];
  List<Dish> get listBeverages => _listBeverages;

  // Cria uma função Future

  Future<List<Restaurant>> getRestaurant() async {
    if (_listRestaurant.isNotEmpty) {
      return _listRestaurant; // evita recarregar se já tiver caregado uma vez
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> restaurantData = data['restaurants'];
      _listRestaurant
          .addAll(restaurantData.map((e) => Restaurant.fromMap(e)).toList());
        final List<dynamic> beverageData = data['beverages'] ?? [];
        _listBeverages
          .addAll(beverageData.map((e) => Dish.fromMap(e)).toList());
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao carregar restaurants $e');
    }

    return _listRestaurant;
  }
}
