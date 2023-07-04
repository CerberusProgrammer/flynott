import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flynott/components/components.dart';
import 'package:flynott/components/providers/home_provider.dart';
import 'package:flynott/components/providers/time_provider.dart';
import 'package:flynott/components/widgets/shared/custom_appbar.dart';
import 'package:flynott/infrastructure/models/category_note.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/categories_notes_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  static const appRouterName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String greetings = ref.watch(greetingProvider);
    String time = ref.watch(actualTime);
    List<CategoryNote> notes = ref.watch(categoriesNotes);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              title: greetings,
              date: time,
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

class _CardCategoryNote extends ConsumerWidget {
  final CategoryNote categoryNote;

  const _CardCategoryNote({
    required this.categoryNote,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 0,
        color: categoryNote.color,
        child: InkWell(
          onTap: () {
            ref.read(selectedCategory.notifier).state = categoryNote;
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
