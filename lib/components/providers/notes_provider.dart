import 'package:flutter/material.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/models/note.dart';

class NotesProvider extends ChangeNotifier {
  List<CategoryNote> categories = [];
  bool toggleThemeDisplayNote = false;
  bool isChanged = false;
  int indexCategory = 0;
  int indexNote = 0;

  void loadTestData() {
    categories.add(
      CategoryNote(
        date: '03 Jul 2023',
        notes: [
          Note(
              title: 'title',
              date: '03 Jul 2023',
              content: 'content',
              index: 0),
          Note(
              title: 'title',
              date: '10 May 2023',
              content: 'content',
              index: 1),
          Note(
              title: 'title',
              date: '21 Apr 2023',
              content: 'content',
              index: 2),
          Note(
              title: 'title',
              date: '13 Mar 2023',
              content: 'content',
              index: 3),
          Note(
              title: 'title',
              date: '02 Feb 2023',
              content: 'content',
              index: 4),
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

  Color getColorCategory() {
    return categories[indexCategory].color;
  }

  void toggleThemeNote() {
    toggleThemeDisplayNote = !toggleThemeDisplayNote;
    notifyListeners();
  }

  // Note functions.
  void updateNoteTitle(int indexCategory, int indexNote, String value) {
    isChanged = true;
    categories[indexCategory].notes[indexNote].title = value;
  }

  void updateDate() {
    categories[indexCategory].notes[indexNote].date =
        DateFormat('dd MMMM yyyy').format(DateTime.now());
    isChanged = false;
  }

  void updateNoteContet(int indexCategory, int indexNote, String value) {
    isChanged = true;
    categories[indexCategory].notes[indexNote].content = value;
  }

  void removeNote(int indexCategory, int indexNote) {
    categories[indexCategory].notes.removeAt(indexNote);
    categories[indexCategory].quantityNotes--;
    notifyListeners();
  }

  void addNewNote(
      int indexCategory, String title, String date, String content) {
    categories[indexCategory].quantityNotes++;
    categories[indexCategory].notes.insert(
        0,
        Note(
            index: categories.length,
            title: title,
            date: date,
            content: content));
    notifyListeners();
  }

  // Miscellaneous
  void updateInBack() {
    notifyListeners();
  }
}
