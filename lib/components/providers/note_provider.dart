import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/models/category_note.dart';
import '../../infrastructure/models/note.dart';

enum NoteFilter { dateAscending, dateDescending }

class NoteProvider extends ChangeNotifier {
  final List<CategoryNote> _categories;
  List<Note> _filteredNotes = [];
  CategoryNote? _selectedCategory;
  Note? _selectedNote;

  bool _toggleThemeDisplayNote = false;

  NoteProvider(this._categories);

  List<CategoryNote> get categories => _categories;
  List<Note> get filteredNotes => _filteredNotes;
  CategoryNote? get selectedCategory => _selectedCategory;
  Note? get selectedNote => _selectedNote;

  bool get toggleThemeDisplayNote => _toggleThemeDisplayNote;

  void toggleTheme() {
    _toggleThemeDisplayNote = !_toggleThemeDisplayNote;
    notifyListeners();
  }

  void selectCategory(CategoryNote category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void selectNote(Note note) {
    _selectedNote = note;
    notifyListeners();
  }

  void addCategory(CategoryNote category) {
    _categories.add(category);
    notifyListeners();
  }

  // Método para eliminar una categoría
  void deleteCategory(CategoryNote category) {
    _categories.remove(category);
    if (_selectedCategory == category) {
      _selectedCategory = null;
    }
    notifyListeners();
  }

  void updateCategory(CategoryNote oldCategory, CategoryNote newCategory) {
    int index = _categories.indexOf(oldCategory);
    if (index != -1) {
      _categories[index] = newCategory;
      if (_selectedCategory == oldCategory) {
        _selectedCategory = newCategory;
      }
      notifyListeners();
    }
  }

  void addNoteToSelectedCategory(Note note) {
    if (_selectedCategory != null) {
      _selectedCategory!.notes.insert(0, note);
      _filteredNotes.insert(0, note);
      _selectedCategory!.quantityNotes++;
      notifyListeners();
    }
  }

  void deleteNoteFromSelectedCategory(Note note) {
    if (_selectedCategory != null) {
      _selectedCategory!.notes.remove(note);
      _selectedCategory!.quantityNotes--;
      if (_selectedNote == note) {
        _selectedNote = null;
      }
      notifyListeners();
    }
  }

  void updateNoteInSelectedCategory(Note oldNote, Note newNote) {
    if (_selectedCategory != null) {
      int index = _selectedCategory!.notes.indexOf(oldNote);
      if (index != -1) {
        _selectedCategory!.notes[index] = newNote;
        if (_selectedNote == oldNote) {
          _selectedNote = newNote;
        }
        notifyListeners();
      }
    }
  }

  void updateNote(Note oldNote, Note newNote) {
    if (_selectedCategory != null) {
      int index = _selectedCategory!.notes.indexOf(oldNote);
      if (index != -1) {
        _selectedCategory!.notes[index] = newNote;
        if (_selectedNote == oldNote) {
          _selectedNote = newNote;
        }
        notifyListeners();
      }
    }
  }

  void filterNotes(NoteFilter filter) {
    final dateFormat = DateFormat('dd MMM yyyy');
    switch (filter) {
      case NoteFilter.dateAscending:
        _filteredNotes.sort((a, b) {
          final dateA = dateFormat.parse(a.date);
          final dateB = dateFormat.parse(b.date);
          return dateA.compareTo(dateB);
        });
        break;
      case NoteFilter.dateDescending:
        _filteredNotes.sort((a, b) {
          final dateA = dateFormat.parse(a.date);
          final dateB = dateFormat.parse(b.date);
          return dateB.compareTo(dateA);
        });
        break;
    }
    notifyListeners();
  }

  void searchNotes(String query) {
    if (_selectedCategory != null) {
      if (query.isEmpty) {
        _filteredNotes = List.from(_selectedCategory!.notes);
      } else {
        _filteredNotes = _selectedCategory!.notes
            .where((note) => note.title.contains(query))
            .toList();
      }
      notifyListeners();
    }
  }

  void update() {
    notifyListeners();
  }

  void load() {
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
}
