import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:flynott/infrastructure/models/note.dart';
import 'package:intl/intl.dart';

final selectedNote = StateProvider<Note?>((ref) => null);

final selectedCategory = StateProvider<CategoryNote?>((ref) => null);

final categoriesNotes = StateProvider<List<CategoryNote>>(
  (ref) {
    List<CategoryNote> notes = [
      CategoryNote(
        date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        notes: [
          Note(title: 'title', date: 'date', content: 'content'),
          Note(title: 'title', date: 'date', content: 'content'),
          Note(title: 'title', date: 'date', content: 'content'),
          Note(title: 'title', date: 'date', content: 'content'),
          Note(title: 'title', date: 'date', content: 'content'),
        ],
        quantityNotes: 1,
        title: 'Material Design',
      ),
      CategoryNote(
        date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        notes: [
          Note(title: 'title', date: 'date', content: 'content'),
        ],
        quantityNotes: 1,
        title: 'Material Design',
      ),
    ];

    return notes;
  },
);
