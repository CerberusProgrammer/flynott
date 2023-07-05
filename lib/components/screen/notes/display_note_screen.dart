import 'package:flutter/material.dart';
import 'package:flynott/components/providers/times_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/note_provider.dart';

class DisplayNoteScreen extends StatefulWidget {
  const DisplayNoteScreen({Key? key}) : super(key: key);

  static const String appRouterName = "display-note-screen";

  @override
  State<DisplayNoteScreen> createState() => _DisplayNoteScreen();
}

class _DisplayNoteScreen extends State<DisplayNoteScreen> {
  // Crea una instancia de TextEditingController en el estado del widget
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Inicializa los TextEditingController con el título y el contenido de la nota seleccionada
    final note = context.read<NoteProvider>().selectedNote;
    _titleController = TextEditingController(text: note?.title ?? '');
    _contentController = TextEditingController(text: note?.content ?? '');
  }

  @override
  void dispose() {
    // Libera los recursos utilizados por los TextEditingController cuando el widget se desecha
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final note = context.watch<NoteProvider>().selectedNote;
    final actualDate = context.watch<TimesProvider>().actualTime;
    bool theme = context.watch<NoteProvider>().toggleThemeDisplayNote;

    if (note == null) {
      return const Center();
    }

    return Scaffold(
      backgroundColor: theme
          ? context.watch<NoteProvider>().selectedCategory?.color
          : Colors.white,
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.black.withOpacity(.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MyCustomAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 11, 30, 21),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        onChanged: (value) {
                          // Actualiza el título de la nota en el NotesProvider
                          context
                              .read<NoteProvider>()
                              .updateNote(note, note.copyWith(title: value));
                        },
                        cursorColor: Colors.grey,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Untitled',
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2))),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        note.date != '' ? note.date : actualDate,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (value) {
                          // Actualiza el contenido de la nota en el NotesProvider
                          context
                              .read<NoteProvider>()
                              .updateNote(note, note.copyWith(content: value));
                        },
                        controller: _contentController,
                        maxLines: null,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Lorem ipsum dolor sit amet, consectetur...',
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2))),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyCustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<NoteProvider>();
    bool theme = provider.toggleThemeDisplayNote;

    return SafeArea(
      child: SizedBox(
        height: 74,
        child: Container(
          color: theme ? provider.selectedCategory?.color : Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(23, 16, 23, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 23, 0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Card(
                      elevation: 0,
                      color: const Color(0xFFD9D9D9).withOpacity(0.5),
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 24,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Card(
                      elevation: 0,
                      color: const Color(0xFFD9D9D9).withOpacity(0.5),
                      child: InkWell(
                        onTap: () {
                          provider.toggleTheme();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Icon(
                          Icons.light_mode_outlined,
                          size: 24,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Card(
                    elevation: 0,
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        // Obtiene la nota seleccionada del NotesProvider
                        final note = provider.selectedNote;
                        provider.deleteNoteFromSelectedCategory(note!);

                        context.pop();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.delete_outline,
                        size: 24,
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
