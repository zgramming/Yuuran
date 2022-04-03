import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final hFont = GoogleFonts.quicksand();
final hFontWhite = hFont.copyWith(color: Colors.white);

TextTheme bFontTextTheme(BuildContext context) =>
    GoogleFonts.ralewayDotsTextTheme(Theme.of(context).textTheme);
final bFont = GoogleFonts.raleway();
final bFontWhite = bFont.copyWith(color: Colors.white);
