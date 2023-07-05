import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimesProvider extends ChangeNotifier {
  late String actualTime;

  void initTime() {
    actualTime = DateFormat('dd MMM yyyy').format(DateTime.now());
  }

  String getGreetings() {
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
  }
}
