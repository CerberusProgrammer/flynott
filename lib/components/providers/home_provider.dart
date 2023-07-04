import 'package:flutter_riverpod/flutter_riverpod.dart';

final greetingProvider = StateProvider((ref) {
  final now = DateTime.now();
  final hour = now.hour;
  String greeting;

  if (hour >= 8 && hour < 12) {
    greeting = 'Good Morning';
  } else if (hour >= 12 && hour < 20) {
    greeting = 'Good Afternoon';
  } else {
    greeting = 'Good Night';
  }

  return greeting;
});
