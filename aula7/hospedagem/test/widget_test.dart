// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:hospedagem/model/destination.dart';

void main() {
  test('Destination stores travel information', () {
    const destination = Destination(
      name: 'Paris',
      image: 'assets/paris.jpg',
      dailyRate: 546,
      guestRate: 95,
    );

    expect(destination.name, 'Paris');
    expect(destination.image, 'assets/paris.jpg');
    expect(destination.dailyRate, 546);
    expect(destination.guestRate, 95);
  });
}
