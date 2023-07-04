import 'package:flutter/material.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/models/note.dart';

class NotesProvider extends ChangeNotifier {
  List<CategoryNote> categories = [];
  int indexCategory = 0;
  int indexNote = 0;

  void loadTestData() {
    categories.add(
      CategoryNote(
        date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        notes: [
          Note(title: 'title', date: 'date', content: 'content', index: 0),
          Note(title: 'title', date: 'date', content: 'content', index: 1),
          Note(title: 'title', date: 'date', content: 'content', index: 2),
          Note(title: 'title', date: 'date', content: 'content', index: 3),
          Note(title: 'title', date: 'date', content: 'content', index: 4),
        ],
        quantityNotes: 5,
        title: 'Material Design',
      ),
    );

    categories.add(
      CategoryNote(
        date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        notes: [
          Note(title: 'title', date: 'date', content: 'content', index: 5),
        ],
        quantityNotes: 1,
        title: 'Material Design',
      ),
    );
  }

  // Note functions.
  void updateNoteTitle(int indexCategory, int indexNote, String value) {
    categories[indexCategory].notes[indexNote].title = value;
  }

  void updateNoteContet(int indexCategory, int indexNote, String value) {
    categories[indexCategory].notes[indexNote].content = value;
  }

  void removeNote(int indexCategory, int indexNote) {
    categories[indexCategory].notes.removeAt(indexNote);
  }

  void addNewNote(
    int indexCategory,
    String title,
    String date,
    String content,
  ) {
    categories[indexCategory].quantityNotes++;
    categories[indexCategory].notes.add(
          Note(
            index: categories.length,
            title: title,
            date: date,
            content: content,
          ),
        );
    notifyListeners();
  }

  // Miscellaneous
  void updateInBack() {
    notifyListeners();
  }
}
