import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.cabinTextTheme(),
      );
}
