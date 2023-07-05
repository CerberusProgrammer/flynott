import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/models/category_note.dart';
import '../../infrastructure/models/note.dart';

enum NoteFilter { dateAscending, dateDescending }

class NoteProvider extends ChangeNotifier {
  // Lista de categorías
  final List<CategoryNote> _categories;
  // Categoría seleccionada
  CategoryNote? _selectedCategory;
  // Nota seleccionada
  Note? _selectedNote;

  bool _toggleThemeDisplayNote = false;

  // Constructor que recibe la lista de categorías
  NoteProvider(this._categories);

  // Getter para obtener la lista de categorías
  List<CategoryNote> get categories => _categories;
  // Getter para obtener la categoría seleccionada
  CategoryNote? get selectedCategory => _selectedCategory;
  // Getter para obtener la nota seleccionada
  Note? get selectedNote => _selectedNote;

  bool get toggleThemeDisplayNote => _toggleThemeDisplayNote;

  void toggleTheme() {
    _toggleThemeDisplayNote = !_toggleThemeDisplayNote;
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

  // Método para seleccionar una categoría
  void selectCategory(CategoryNote category) {
    // Asigna la categoría a la variable _selectedCategory
    _selectedCategory = category;
    // Notifica a los widgets que estén escuchando los cambios
    notifyListeners();
  }

  // Método para seleccionar una nota
  void selectNote(Note note) {
    // Asigna la nota a la variable _selectedNote
    _selectedNote = note;
    // Notifica a los widgets que estén escuchando los cambios
    notifyListeners();
  }

  // Método para agregar una categoría
  void addCategory(CategoryNote category) {
    // Añade la categoría a la lista de categorías
    _categories.add(category);
    // Notifica a los widgets que estén escuchando los cambios
    notifyListeners();
  }

  // Método para eliminar una categoría
  void deleteCategory(CategoryNote category) {
    // Elimina la categoría de la lista de categorías
    _categories.remove(category);
    // Si esa categoría era la categoría seleccionada, actualiza la variable _selectedCategory para indicar que ya no hay ninguna categoría seleccionada
    if (_selectedCategory == category) {
      _selectedCategory = null;
    }
    // Notifica a los widgets que estén escuchando los cambios
    notifyListeners();
  }

  // Método para actualizar una categoría
  void updateCategory(CategoryNote oldCategory, CategoryNote newCategory) {
    // Busca la categoría antigua en la lista de categorías y obtiene su índice
    int index = _categories.indexOf(oldCategory);
    if (index != -1) {
      // Reemplaza la categoría antigua con la nueva categoría en la lista de categorías
      _categories[index] = newCategory;
      // Si la categoría antigua era la categoría seleccionada, actualiza la variable _selectedCategory para indicar que ahora la nueva categoría es la seleccionada
      if (_selectedCategory == oldCategory) {
        _selectedCategory = newCategory;
      }
      // Notifica a los widgets que estén escuchando los cambios
      notifyListeners();
    }
  }

  // Método para agregar una nota a la categoría seleccionada
  void addNoteToSelectedCategory(Note note) {
    if (_selectedCategory != null) {
      // Añade la nota a la lista de notas de la categoría seleccionada
      _selectedCategory!.notes.insert(0, note);
      _selectedCategory!.quantityNotes++;
      // Notifica a los widgets que estén escuchando los cambios
      notifyListeners();
    }
  }

  // Método para eliminar una nota de la categoría seleccionada
  void deleteNoteFromSelectedCategory(Note note) {
    if (_selectedCategory != null) {
      // Elimina la nota de la lista de notas de la categoría seleccionada
      _selectedCategory!.notes.remove(note);
      _selectedCategory!.quantityNotes--;
      // Si esa nota era la nota seleccionada, actualiza la variable _selectedNote para indicar que ya no hay ninguna nota seleccionada
      if (_selectedNote == note) {
        _selectedNote = null;
      }
      // Notifica a los widgets que estén escuchando los cambios
      notifyListeners();
    }
  }

  // Método para actualizar una nota en la categoría seleccionada
  void updateNoteInSelectedCategory(Note oldNote, Note newNote) {
    if (_selectedCategory != null) {
      // Busca la nota antigua en la lista de notas de la categoría seleccionada y obtiene su índice
      int index = _selectedCategory!.notes.indexOf(oldNote);
      if (index != -1) {
        // Reemplaza la nota antigua con la nueva nota en la lista de notas de la categoría seleccionada
        _selectedCategory!.notes[index] = newNote;
        // Si la nota antigua era la nota seleccionada, actualiza la variable _selectedNote para indicar que ahora la nueva nota es the seleccionada
        if (_selectedNote == oldNote) {
          _selectedNote = newNote;
        }
        // Notifica a los widgets que estén escuchando los cambios
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
    if (_selectedCategory != null) {
      final dateFormat = DateFormat('dd MMM yyyy');
      switch (filter) {
        case NoteFilter.dateAscending:
          _selectedCategory!.notes.sort((a, b) {
            final dateA = dateFormat.parse(a.date);
            final dateB = dateFormat.parse(b.date);
            return dateA.compareTo(dateB);
          });
          break;
        case NoteFilter.dateDescending:
          _selectedCategory!.notes.sort((a, b) {
            final dateA = dateFormat.parse(a.date);
            final dateB = dateFormat.parse(b.date);
            return dateB.compareTo(dateA);
          });
          break;
      }
      notifyListeners();
    }
  }
}
