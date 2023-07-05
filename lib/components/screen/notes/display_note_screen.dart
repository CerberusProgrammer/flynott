import 'package:flutter/material.dart';
import 'package:flynott/components/providers/times_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/notes_provider.dart';

class DisplayNoteScreen extends StatelessWidget {
  const DisplayNoteScreen({super.key});

  static const String appRouterName = "display-note-screen";

  @override
  Widget build(BuildContext context) {
    final indexCategory = context.watch<NotesProvider>().indexCategory;
    final indexNote = context.watch<NotesProvider>().indexNote;
    final notes = context.watch<NotesProvider>().categories;
    final categoryNote = notes[indexCategory];
    final note = categoryNote.notes[indexNote];
    final actualDate = context.watch<TimesProvider>().actualTime;
    bool theme = context.watch<NotesProvider>().toggleThemeDisplayNote;

    return Scaffold(
      backgroundColor: theme
          ? context.watch<NotesProvider>().getColorCategory()
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: TextEditingController(text: note.title),
                      onChanged: (value) {
                        context.read<NotesProvider>().updateNoteTitle(
                              indexCategory,
                              indexNote,
                              value,
                            );
                      },
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
                        context.read<NotesProvider>().updateNoteContet(
                              indexCategory,
                              indexNote,
                              value,
                            );
                      },
                      controller: TextEditingController(text: note.content),
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
  @override
  Widget build(BuildContext context) {
    final provider = context.read<NotesProvider>();
    bool theme = provider.toggleThemeDisplayNote;

    return SafeArea(
      child: SizedBox(
        height: 74,
        child: Container(
          color: theme ? provider.getColorCategory() : Colors.white,
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
                          if (provider.isChanged) {
                            provider.updateDate();
                          }

                          provider.updateInBack();
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
                          provider.toggleThemeNote();
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
                        provider.removeNote(
                            provider.indexCategory, provider.indexNote);
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
