import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynott/config/router/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.cabinTextTheme(
            Theme.of(context).textTheme,
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
