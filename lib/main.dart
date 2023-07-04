import 'package:flutter/material.dart';
import 'package:flynott/components/providers/notes_provider.dart';
import 'package:flynott/components/providers/times_provider.dart';
import 'package:flynott/config/router/app_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,
            create: (_) {
              final notes = NotesProvider();
              notes.loadTestData();
              return notes;
            }),
        ChangeNotifierProvider(
            lazy: false,
            create: (_) {
              final times = TimesProvider();
              times.initTime();
              return times;
            }),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.cabinTextTheme(
              Theme.of(context).textTheme,
            )),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
