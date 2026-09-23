import 'destination.dart';

class Reservation {
  const Reservation({
    required this.destination,
    required this.days,
    required this.companions,
    required this.total,
  });

  final Destination destination;
  final int days;
  final int companions;
  final int total;
}
