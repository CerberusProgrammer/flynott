import 'package:flutter/material.dart';
import 'package:flynott/components/providers/times_provider.dart';
import 'package:flynott/config/router/app_router.dart';
import 'package:flynott/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'components/providers/note_provider.dart';

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
              final times = TimesProvider();
              times.initTime();
              return times;
            }),
        ChangeNotifierProvider(
            lazy: false,
            create: (_) {
              final notes = NoteProvider([]);
              notes.load();
              return notes;
            }),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme().appTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
