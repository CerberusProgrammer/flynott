import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flynott/components/components.dart';
import 'package:flynott/components/providers/notes_provider.dart';
import 'package:flynott/components/providers/times_provider.dart';
import 'package:flynott/components/widgets/shared/custom_appbar.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const appRouterName = 'home';

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NotesProvider>().categories;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              title: context.watch<TimesProvider>().getGreetings(),
              date: context.watch<TimesProvider>().actualTime,
              icon: Icons.settings,
            ),
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: StaggeredGrid.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                children: List.generate(
                  notes.length,
                  (index) => _CardCategoryNote(
                    categoryNote: notes[index],
                    index: index,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: const Color(0xFFD9D9D9),
        splashColor: const Color.fromARGB(146, 255, 255, 255),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _CardCategoryNote extends StatelessWidget {
  final CategoryNote categoryNote;
  final int index;

  const _CardCategoryNote({
    required this.categoryNote,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 0,
        color: categoryNote.color,
        child: InkWell(
          onTap: () {
            context.read<NotesProvider>().indexCategory = index;
            context.pushNamed(CategoryNotesScreen.appRouterName);
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 15, 0, 0),
                child: Text(
                  categoryNote.quantityNotes < 10
                      ? '0${categoryNote.quantityNotes}'
                      : categoryNote.quantityNotes.toString(),
                  style: GoogleFonts.josefinSans(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 33, 13, 0),
                child: Text(
                  categoryNote.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 2, 13, 15),
                child: Text(
                  categoryNote.date,
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
