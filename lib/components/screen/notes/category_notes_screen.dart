import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flynott/components/components.dart';
import 'package:flynott/components/screen/notes/create_note_screen.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:flynott/infrastructure/models/note.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/note_provider.dart';

class CategoryNotesScreen extends StatefulWidget {
  const CategoryNotesScreen({super.key});

  static const String appRouterName = 'category-notes-screen';

  @override
  State<CategoryNotesScreen> createState() => _CategoryNotesScreenState();
}

class _CategoryNotesScreenState extends State<CategoryNotesScreen> {
  @override
  void initState() {
    super.initState();
    // Inicializa la lista de notas filtradas
    Provider.of<NoteProvider>(context, listen: false).searchNotes('');
  }

  @override
  Widget build(BuildContext context) {
    final categoryNote = context.watch<NoteProvider>().selectedCategory;

    if (categoryNote == null) {
      return const Center(child: Text('No hay ninguna categoría seleccionada'));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _MyCustomAppBar(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 11, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryNote.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  categoryNote.date,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: StaggeredGrid.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              children: List.generate(
                context.watch<NoteProvider>().filteredNotes.length,
                (index) => _CardNote(
                  note: context.watch<NoteProvider>().filteredNotes[index],
                  category: categoryNote,
                  index: index,
                ),
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: const Color(0xFFD9D9D9),
        splashColor: const Color.fromARGB(146, 255, 255, 255),
        onPressed: () {
          context.pushNamed(CreateNoteScreen.appRouterName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _MyCustomAppBar extends StatefulWidget {
  @override
  _MyCustomAppBarState createState() => _MyCustomAppBarState();
}

class _MyCustomAppBarState extends State<_MyCustomAppBar> {
  bool _showExtraWidgets = false;
  bool _showTextField = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      Provider.of<NoteProvider>(context, listen: false)
          .searchNotes(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.removeListener(() {
      Provider.of<NoteProvider>(context, listen: false)
          .searchNotes(_textController.text);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 74,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(23, 16, 23, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
              if (_showTextField)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: FadeIn(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          textSelectionTheme: TextSelectionThemeData(
                            selectionColor: Colors.black.withOpacity(.1),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            autofocus: true,
                            controller: _textController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.1),
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              else
                const Spacer(),
              if (_showExtraWidgets) ...[
                FadeIn(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Card(
                      elevation: 0,
                      color: const Color(0xFFD9D9D9).withOpacity(0.5),
                      child: InkWell(
                          onTap: () {
                            Provider.of<NoteProvider>(context, listen: false)
                                .filterNotes(NoteFilter.dateAscending);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Icon(Icons.arrow_upward,
                              size: 24, color: Colors.black.withOpacity(.5))),
                    ),
                  ),
                ),
                FadeIn(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Card(
                        elevation: 0,
                        color: const Color(0xFFD9D9D9).withOpacity(0.5),
                        child: InkWell(
                            onTap: () {
                              Provider.of<NoteProvider>(context, listen: false)
                                  .filterNotes(NoteFilter.dateDescending);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Icon(Icons.arrow_downward,
                                size: 24,
                                color: Colors.black.withOpacity(.5)))),
                  ),
                ),
              ],
              SizedBox(
                width: 50,
                height: 50,
                child: Card(
                    elevation: 0,
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _showExtraWidgets = !_showExtraWidgets;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Icon(Icons.filter_alt_outlined,
                            size: 24, color: Colors.black.withOpacity(.5)))),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Card(
                    elevation: 0,
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _showTextField = !_showTextField;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Icon(Icons.search,
                            size: 24, color: Colors.black.withOpacity(.5)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardNote extends StatelessWidget {
  final CategoryNote category;
  final Note note;
  final int index;

  const _CardNote({
    required this.note,
    required this.category,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 0,
        color: category.color,
        child: InkWell(
          onTap: () {
            // Selecciona la nota en el NotesProvider
            context.read<NoteProvider>().selectNote(note);
            // Navega a la pantalla de visualización de la nota
            context.replaceNamed(DisplayNoteScreen.appRouterName);
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                child: Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 2, 13, 15),
                child: Text(
                  note.date,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.4),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
