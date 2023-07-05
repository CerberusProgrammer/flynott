import 'package:flutter/material.dart';
import 'package:flynott/components/providers/times_provider.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/models/note.dart';
import '../../providers/note_provider.dart';

TextEditingController _titleEditingController = TextEditingController();
TextEditingController _contetsEditingController = TextEditingController();

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key});

  static const String appRouterName = "create-note-screen";

  @override
  Widget build(BuildContext context) {
    final actualDate = context.watch<TimesProvider>().actualTime;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.black.withOpacity(.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MyCustomAppBar(actualDate),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 11, 30, 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleEditingController,
                      cursorColor: Colors.grey,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Untitled',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.2))),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      actualDate,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _contetsEditingController,
                      maxLines: null,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'Lorem ipsum dolor sit amet, consectetur...',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.2))),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
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
  final String actualDate;

  const _MyCustomAppBar(this.actualDate);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 74,
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
                        // Verifica que el título y el contenido no estén vacíos
                        if (_titleEditingController.text.isNotEmpty ||
                            _contetsEditingController.text.isNotEmpty) {
                          // Crea una nueva nota con el título y el contenido especificados por el usuario
                          final note = Note(
                              index:
                                  -1, // El índice no importa porque se va a agregar a la lista de notas de la categoría seleccionada
                              title: _titleEditingController.text,
                              date: actualDate,
                              content: _contetsEditingController.text);
                          // Agrega la nota a la categoría seleccionada en el NoteProvider
                          context
                              .read<NoteProvider>()
                              .addNoteToSelectedCategory(note);
                        }
                        // Limpia los campos de texto
                        _titleEditingController.clear();
                        _contetsEditingController.clear();
                        // Regresa a la pantalla anterior
                        Navigator.of(context).pop();
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
            ],
          ),
        ),
      ),
    );
  }
}
