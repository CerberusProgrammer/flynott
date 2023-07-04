import 'dart:ui';

import 'package:flynott/infrastructure/models/note.dart';

class CategoryNote {
  int quantityNotes;
  String title;
  String date;
  List<Note> notes;
  Color color;

  CategoryNote({
    required this.quantityNotes,
    required this.title,
    required this.date,
    required this.notes,
    this.color = const Color(0xFFFFF377),
  });
}
