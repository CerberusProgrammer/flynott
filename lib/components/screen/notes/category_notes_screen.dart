import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flynott/components/components.dart';
import 'package:flynott/components/screen/notes/create_note_screen.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:flynott/infrastructure/models/note.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/notes_provider.dart';

class CategoryNotesScreen extends StatelessWidget {
  const CategoryNotesScreen({super.key});

  static const String appRouterName = 'category-notes-screen';

  @override
  Widget build(BuildContext context) {
    final indexCategory = context.watch<NotesProvider>().indexCategory;
    final notes = context.watch<NotesProvider>().categories;
    final categoryNote = notes[indexCategory];

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
                categoryNote.notes.length,
                (index) => _CardNote(
                  note: categoryNote.notes[index],
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

class _MyCustomAppBar extends StatelessWidget {
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
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Card(
                    elevation: 0,
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        // TODO: Filter
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(
                        Icons.filter_alt_rounded,
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
                      // TODO: search
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      Icons.search,
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
            context.read<NotesProvider>().indexNote = index;
            context.pushNamed(DisplayNoteScreen.appRouterName);
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
