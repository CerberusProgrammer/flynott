import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final actualTime =
    StateProvider((ref) => DateFormat('dd MMMM yyyy').format(DateTime.now()));
